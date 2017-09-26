class SlideTemplate < ActiveRecord::Base
  belongs_to :organization
  has_many :slide_assets, inverse_of: :slide_template
  serialize :hook_list
  # hook_list e.g. [{hook: "__SRC1__", description: "The main image source"}, {hook: "__SRC2__", description: "The rss source"}]
end
