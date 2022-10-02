class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :url
      t.string :var_name
      t.string :distinguer
      t.string :path
      t.string :wanted_value
      t.references :notification_model
      t.timestamps
    end
  end
end
