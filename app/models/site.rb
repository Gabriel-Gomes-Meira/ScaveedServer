class Site
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :url, type: String

  embeds_many :listens

  validates_presence_of :name, :url
end
