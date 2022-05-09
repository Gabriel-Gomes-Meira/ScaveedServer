class Listen
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :url, type: String

  belongs_to :site
  embeds_one :item, store_as: "searched_item"
  # embeds_many :item, store_as: "wanted_items"

  validates_presence_of :name, :url, :item
end
