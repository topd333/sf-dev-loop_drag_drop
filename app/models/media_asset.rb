class MediaAsset < ActiveRecord::Base

  belongs_to :organization
  has_many :slide_media_hooks, inverse_of: :media_asset
  has_many :slide_assets, through: :slide_media_hooks
  has_attached_file :asset_file,
    :styles => lambda { |ma|
      if ma.instance.is_image?
        {
          :original => "1920x1080>", 
          :thumb => "225x170#"
        }
      elsif ma.instance.is_video?
        {
          :thumb => {
            :format => 'png',
            convert_options: {
              output: { 
                strict: "experimental", ss: 1, vframes: 1, s: "225x170" 
              }
            }
          }
        }
      end
      },
    :processors => lambda { |instance|
      if instance.is_image?
        return [:thumbnail]
      elsif instance.is_video?
        return [:transcoder]
      end
      },
    :default_url => 'placeholder225x170.gif'
  validates_attachment_presence :asset_file
  validates_attachment_content_type :asset_file, :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png", "video/mp4", "video/ogg", "video/webm", "video/x-matroska"]
  validates_attachment_file_name :asset_file, :matches => [/jpe?g\Z/i, /png\Z/i, /mp4\Z/i, /ogg\Z/i, /webm\Z/i, /MKV\Z/i]
  validates_attachment_size :asset_file, :in => 0..500.megabytes # TODO Create conditional sizes based on video/image? or organizations maximum
  validate :allowed_dimensions
  before_create :gen_file_name
  before_save :set_media_duration
  before_destroy :check_for_parents
  after_save :bubble_update

  default_scope { order('created_at DESC') }

  def is_image?
    asset_file.instance.asset_file_content_type.starts_with?('image')
  end
  def is_video?
    asset_file.instance.asset_file_content_type.starts_with?('video')
  end

  def thumbnail_url
    self.asset_file.url(:thumb)
  end

  def asset_icon_type
    self.is_image? ? "image84" : "movie42"
  end

  def media_type
    self.is_image? ? "image" : "video"
  end

  def duration_formatted
    x = duration.to_f / 1000
    #seconds = x % 60
    x.round(1)
    # x /= 60
    # minutes = x % 60
    # x /= 60
    # hours = x % 24
    # x /= 24
    # days = x
    # "#{minutes}m #{seconds}s"
  end

  # Work this update up the chain to flag an update on the player
  def bubble_update
    slide_assets.each{ |slide_asset|
      slide_asset.bubble_update
    }
  end

  private

    def gen_file_name
      extension = File.extname(asset_file_file_name).downcase
      self.asset_file.instance_write(:file_name, "#{SecureRandom.uuid}#{extension}")
    end

    def set_media_duration
      #raise asset_file_meta[:length]
      if self.asset_file_meta != nil
        parts = self.asset_file_meta[:length].split(':')
        self.duration = (parts[0].to_i*3600000) + (parts[1].to_i*60000) + (parts[2].to_f*1000)
      end
    end

    def allowed_dimensions
      if is_video?
        size = self.asset_file_meta[:size].split('x')
        if size[0].to_i > 1920 || size[1].to_i > 1080
          errors.add(:asset_file, "cannot be larger than 1920 x 1080")
        end
      end
    end

    def check_for_parents
      if slide_assets.any?
        errors.add(:base, "#{displayname} cannot be deleted. It is in use by at least one loop.")
        return false
      end
    end

end
