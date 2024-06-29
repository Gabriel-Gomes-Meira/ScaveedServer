class AddColumnModelTaks < ActiveRecord::Migration[7.0]
  def change
    add_column :crons, :params, :text, null: true
    add_column :queued_tasks, :params, :text, null: true
  end
end
