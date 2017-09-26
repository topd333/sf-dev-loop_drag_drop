class SlideAsset < ActiveRecord::Base
  belongs_to :loop_asset
  belongs_to :organization
  belongs_to :slide_template


  before_validation :generate_hook_assets # Mind the order of operations when using autosave!
  has_many :slide_media_hooks, inverse_of: :slide_asset, :dependent => :destroy, autosave: true
  has_many :media_assets, through: :slide_media_hooks
  attr_accessor :hooks_json_string

  validates :duration, presence: true, numericality: true
  validates :organization, presence: true
  validates :loop_asset, presence: true
  validates :slide_template, presence: true
  validates :position, presence: true

  validate :template_accessible
  validate :loop_asset_accessible

  before_create :generate_uuid
  after_save :touch_loop_asset
  after_save :bubble_update

  def thumb_path
    #"placeholder196x110.gif"
    slide_media_hooks.first.media_asset.asset_file.url(:thumb)
  end

  # Work this update up the chain to flag an update on the player
  def bubble_update
    loop_asset.bubble_update
  end

  def media_asset
    media_assets.first
  end

  private
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end

    def generate_hook_assets
      if self.hooks_json_string == nil || self.hooks_json_string.empty?
        #errors.add(:base, "Template sources incomplete")
        #return false
        return
        #TODO FIX THIS!!!
      end
      hooks_meta_object = JSON.parse(self.hooks_json_string)
      self.slide_media_hooks.clear

      # Adam Changed this back! Note: Single slide assets will have multiple media assets when using more complex templates.
      # Find the requested media asset
      # Made some changes here, will re-visit
      #media_asset = get_media_asset(hooks_meta_object["__SRC1__"])
      # Create a new slide-media link.
      #self.slide_media_hooks.build(organization: self.organization, media_asset: media_asset, hook: hooks_meta_object["__SRC1__"])

      # Loop through the hooks required by the template
      self.slide_template.hook_list.each { |expected_hook|
        # Make sure proper hook was provided
        if hooks_meta_object.has_key? expected_hook[:hook]
          # Find the requested media asset
          media_asset = get_media_asset(hooks_meta_object[expected_hook[:hook]])
          # Create a new slide-media link.
          self.slide_media_hooks.build(organization: self.organization, media_asset: media_asset, hook: expected_hook[:hook])
        else
          raise 'Incomplete Template Parameters' # Cancle the transaction if all hooks not provided
        end
      }
      #SAMPLE hooks_meta_object = {"__SRC1__":8, "__SRC2__":44}
    end

    def get_media_asset(media_asset_id)
      media_asset = MediaAsset.find(media_asset_id)
      if media_asset.organization == self.organization
        return media_asset
      else
        raise 'Media not available. Permission Denied.'
      end
    end

    # CUSTOM VALIDATORS
    # Ensure the template is public or belongs to the organization
    def template_accessible
      if slide_template.organization != self.organization && slide_template.organization != nil
        errors.add(:slide_template, "is not available")
      end
    end

    # Ensure the loop asset belongs to the organization
    def loop_asset_accessible
      if loop_asset.organization != self.organization
        errors.add(:loop_asset, "is not accessable")
      end
    end

    # Update timestamp on loop_asset to ensure changes is downloaded to players
    def touch_loop_asset
      loop_asset.touch
    end
end
