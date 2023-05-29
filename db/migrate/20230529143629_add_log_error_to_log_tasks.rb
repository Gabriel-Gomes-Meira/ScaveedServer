class AddLogErrorToLogTasks < ActiveRecord::Migration[7.0]
  def change    
    add_column :queued_tasks, :message_error, :text
  end
end
