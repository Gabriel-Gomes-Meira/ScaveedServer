class WantedItem < Item
  include Mongoid::Document
  include Mongoid::Timestamps
  field :url, type: String
  field :var_name, type: String
  field :distinguer, type: Hash
  field :recursive_path, type: Array
  field :wanted_value, type: String

  embedded_in :notification_model
  validates_uniqueness_of :var_name, message:"Nome já existente nesse modeo de notificação!"
end
