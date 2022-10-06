class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :url, null: false      
      t.string :var_name, null: false
      t.string :distinguer
      t.string :path, null: false
      t.string :wanted_value, null: false
      t.references :notification_model, null: false
      t.timestamps
    end
  end
end
