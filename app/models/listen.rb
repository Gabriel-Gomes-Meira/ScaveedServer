class Listen
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :url, type: String
  field :element_indentifier, type: String
  belongs_to :site
  has_one :notification_model
  has_one :model_task, class_name:"Task",
          inverse_of: :listen, autosave:true

  validates_presence_of :name, :url, :element_indentifier
end
