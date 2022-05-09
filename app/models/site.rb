class Site
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :url, type: String

  has_many :listen

  validates_presence_of :name, :url
end
