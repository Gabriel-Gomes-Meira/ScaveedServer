class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :telegram_token
      t.string :telegram_chatid
      t.timestamps
    end
  end
end
