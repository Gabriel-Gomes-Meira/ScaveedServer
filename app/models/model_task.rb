class ModelTask
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection:"model_tasks"
  field :content, type: Array
  field :file_name, type:String
  belongs_to :listen,
             inverse_of: :model_task
end
