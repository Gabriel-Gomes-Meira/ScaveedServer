class CreateListens < ActiveRecord::Migration[7.0]
  def change
    create_table :listens do |t|
      t.string :name, null: false
      t.string :element_indentifier, null: false
      t.references :site, null: false
      t.references :notification_model
      t.references :model_task
      t.timestamps
    end
  end
end
