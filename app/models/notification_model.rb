class NotificationModel
  include Mongoid::Document
  include Mongoid::Timestamps
  field :message, type: String
  field :listen_name, type: String, default: -> {
    begin
      Listen.find(self[:listen]).name
    rescue Mongoid::Errors::DocumentNotFound
      ""
    end
  }
  belongs_to :listen
  embeds_many :wanted_items
  accepts_nested_attributes_for :wanted_items

  def wi_update_or_create(param_item = {})
    wi = self.wanted_items.where(var_name:param_item[:var_name]).first
    if wi
      wi.update_attributes(param_item)
      return wi.save
    else
      wi = WantedItem.new(param_item)
      wi.notification_model = self
      return wi.save
    end
  end

  def wi_delete(id)
    # self.wanted_items.select! {|wi| wi._id != id}
    # return self.save()
    wi = self.wanted_items.where(_id:id).first
    wi.destroy
  end

end