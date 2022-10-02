class CreateNotificationModels < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_models do |t|
      t.text :message
      t.timestamps
    end
  end
end
