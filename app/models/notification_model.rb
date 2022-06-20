class NotificationModel
  include Mongoid::Document
  include Mongoid::Timestamps
  field :message, type: String
  belongs_to :listen
  embeds_many :wanted_items
  accepts_nested_attributes_for :wanted_items

  def wi_update_or_create(param_item = {})

    if param_item.include?(:id)
      wi = self.wanted_items.where(_id:param_item[:id]).first
      if wi
        wi.update_attributes(param_item.except(:id))
        return wi.save

      else
        nil
      end

    else
      wi = WantedItem.new(param_item)
      wi.notification_model = self
      return wi.save
    end
  end
end