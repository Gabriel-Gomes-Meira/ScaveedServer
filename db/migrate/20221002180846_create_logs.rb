class CreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :logs do |t|
      t.text :message_log
      t.datetime :at
    end
  end
end
