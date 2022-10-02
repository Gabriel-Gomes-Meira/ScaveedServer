class CreateListens < ActiveRecord::Migration[7.0]
  def change
    create_table :listens do |t|
      t.string :name
      t.string :element_indentifier
      t.references :site
      t.references :notification_model
      t.references :model_task
      t.timestamps
    end
  end
end
