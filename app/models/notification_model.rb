class NotificationModel < ApplicationRecord
  has_one :listen
  has_many :items, dependent: :destroy
  def create_item(param_item = {})

    wi = Item.new(param_item.except(:id))
    wi.notification_model_id = self.id
    puts self.id
    while true
      begin
        return wi.save()
      rescue SQLite3::BusyException => e
      end
    end
  end

  def update_item(param_item = {})
    item = Item.find(param_item[:id])
    if item
      return item.update(param_item.except(:id,:notification_model_id))
    else
      return nil
    end
  end

  def delete_item(id)
    Item.delete(id)
  end
end
