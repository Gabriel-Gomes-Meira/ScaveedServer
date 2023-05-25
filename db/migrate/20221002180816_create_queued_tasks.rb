class CreateQueuedTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :queued_tasks do |t|
      t.text :content, null: false
      t.string :file_name, null: false
      t.integer :state, default: 0
      t.text :log
      t.integer :count_erro, default: 0      
      t.datetime :initialized_at
      t.datetime :updated_at
    end
  end
end
