class CreateQueuedTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :queued_tasks do |t|
      t.string :content
      t.string :file_name
      t.integer :state
      t.timestamps
    end
  end
end
