class CreateModelTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :model_tasks do |t|
      t.text :content, null: false
      t.string :file_name, null: false
      # t.references :listen
      t.timestamps
    end
  end
end
