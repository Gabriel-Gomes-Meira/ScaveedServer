class CreateCrons < ActiveRecord::Migration[7.0]
  def change
    create_table :crons do |t|
      t.string :name
      t.string :interval
      t.string :next_run, null: true
      t.references :model_task, null: true, foreign_key: true
      t.timestamps
    end
  end
end
