class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.text :current_state
      t.references :listen
      t.datetime :at
    end
  end
end
