class LoopAsset < ActiveRecord::Base
  attr_accessor :loop_json_string
  belongs_to :organization
  has_many :slide_assets, -> {order(:position)}, inverse_of: :loop_asset, :dependent => :destroy
  has_many :loop_campaign_hooks
  has_many :campaigns, :through => :loop_campaign_hooks

  validates :displayname, presence: true, length: { in: 2..30 }
  validates :organization, presence: true

  before_create :generate_uuid
  before_save :handle_slide_assets

  after_save :bubble_update

  before_destroy :check_for_parents

  default_scope { order('created_at DESC') }

  def thumb_path
    # "placeholder196x110.gif"
    if slide_assets.take
      if slide_assets.take.thumb_path
        return slide_assets.take.thumb_path
      end
    else
      "placeholder196x110.gif"
    end
  end

  # Work this update up the chain to flag an update on the player
  def bubble_update
    campaigns.each{ |campaign|
      campaign.bubble_update
    }
  end

  private
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end

    # Create/Update slide assets
    def handle_slide_assets
      return if self.loop_json_string == nil || self.loop_json_string.empty?
      # parse the json from the javascript loop generation app
      loop_meta_array = JSON.parse(self.loop_json_string)

      slides_in_use = Array.new

      # loop through each proposed slide
      loop_meta_array.each_with_index { |slide_meta_object, index|

        if slide_meta_object['id'] == 'new'
          # CREATE A NEW SLIDE
          slide_asset = self.slide_assets.build({
            organization: self.organization,
            slide_template: SlideTemplate.find(slide_meta_object["slide_template_id"]),
            hooks_json_string: slide_meta_object["hooks_json_string"]
          })
        elsif slide_meta_object['id'] != nil
          # EDIT AN EXISTING SLIDE
          slide_asset = self.slide_assets.find(slide_meta_object['id'])
        else
          return false
        end

        if slide_meta_object["duration"]
          duration = slide_meta_object["duration"].to_f
          if duration == 0.0
            errors[:base] << "Invalid duration characters."
            return false
          end
          slide_asset.duration = (duration * 1000)
        end
        slide_asset.displayname = slide_meta_object["displayname"]
        slide_asset.position = index
        slides_in_use << slide_asset
        slide_asset.save!
      }

      # Marks the unused assets for deletion
      self.slide_assets = slides_in_use

      #SAMPLE loop_json_string = [{"id":14,"duration":4000},{"id":12,"duration":4000}]
    end

    def check_for_parents
      if campaigns.any?
        errors.add(:base, "#{displayname} cannot be deleted. It is in use by at least one campaign.")
        return false
      end
    end
end

# TODO handle copying
