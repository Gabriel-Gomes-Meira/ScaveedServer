class WantedItem < Item
  include Mongoid::Document
  include Mongoid::Timestamps
  field :url, type: String
  field :pre_text, type: String
  field :distinguer, type: Hash
  field :recursive_path, type: Array
  field :wanted_value, type: String

  embedded_in :notification_model
end
