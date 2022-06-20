class WantedItem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :url, type: String
  field :var_name, type: String
  field :distinguer, type: Hash
  field :path, type: String
  field :wanted_value, type: String

  embedded_in :notification_model
  validates_uniqueness_of :var_name, message:"Nome já existente nesse modelo de notificação!"
end
