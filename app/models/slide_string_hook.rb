class SlideStringHook < ActiveRecord::Base
  belongs_to :organization
  belongs_to :slide_asset
end
