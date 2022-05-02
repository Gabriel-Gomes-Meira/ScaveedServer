class Listen
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :url, type: String

  embedded_in :site
  embeds_one :item, store_as: "searched_item"

  validates_presence_of :name, :url
end
