class CreateLogTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :log_tasks do |t|
      t.text :content
      t.string :file_name
      t.integer :state, default: 2
      t.integer :count_erro, default: 0
      t.datetime :initialized_at
      t.datetime :terminated_at, null: false
      t.text :log      
      t.datetime :updated_at
    end
  end
end
