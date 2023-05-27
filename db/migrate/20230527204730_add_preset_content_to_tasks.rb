class AddPresetContentToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :model_tasks, :preset_content, :text
    add_column :queued_tasks, :preset_content, :text
    add_column :log_tasks, :preset_content, :text    
  end
end
