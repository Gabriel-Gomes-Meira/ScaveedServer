class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.text :current_state, null: false
      t.references :listen, null: false
      t.datetime :at, null: false
    end
  end
end
