class ModelTask
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection:"model_tasks"
  field :content, type: Array
  field :file_name, type:String
  field :listen_name, type:String, default: -> {
    begin
      Listen.find(self[:listen]).name
    rescue Mongoid::Errors::DocumentNotFound
      ""
    rescue Mongoid::Errors::InvalidFind
      ""
    end
  }
  belongs_to :listen,
             inverse_of: :model_task
end
