class CreateModelTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :model_tasks do |t|
      t.string :content
      t.string :file_name
      t.references :listen
      t.timestamps
    end
  end
end
