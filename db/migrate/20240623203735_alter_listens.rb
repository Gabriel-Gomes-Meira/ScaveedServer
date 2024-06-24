class AlterListens < ActiveRecord::Migration[7.0]
  def up
    change_table  :listens do |t|
      t.integer :interval, null: true
      t.string :next_run, null: true
    end
  end

  def down
    change_table :listens do |t|
      t.remove :interval
      t.remove :next_run
    end
  end
end
