class AddModelTaskRefToListen < ActiveRecord::Migration[7.0]
  def change
    add_reference :listens, :model_tasks, foreign_key: true, null: true
  end
end
