class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection:"queued_tasks"
  field :content, type: Array
  field :file_name, type:String
  field :state, type:Integer, default: 0
end
