class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :telegram, type: Hash

  validates_presence_of :telegram
end
