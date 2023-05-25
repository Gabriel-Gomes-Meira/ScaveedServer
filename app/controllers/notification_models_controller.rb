class NotificationModelsController < ApplicationController
  def index
    resp = []

    for r in NotificationModel.joins(:listen).select("notification_models.*, listens.name as listen_name, listens.id
as listen_id") do
      item  = r.attributes
      item[:wanted_items] = Item.where(notification_model_id: r.id)
      resp.push(item)
      # r[:items] = []
      # r[:items] =  Item.find_by_notification_model_id(r.id)
    end

    render json: resp
  end

  def create
    # return render json:params[:model][:wanted_items], status: :bad_request
    nm = NotificationModel.new(:message =>params_model)
    listen = Listen.find(params[:listen_id])
    
    if nm.save()
      listen.notification_model_id = nm.id
      listen.save()
      for item in params_itens[:items] do
        # return render json:nm.wi_update_or_create(item),status: :temporary_redirect
        wi = nm.create_item(item)
        if !wi
          nm.destroy
          return render json: wi.errors, status: :unprocessable_entity
        end
      end
      return render json: nm, status: :created
    else
      return render json: nm.errors, status: :unprocessable_entity
    end
  end

  def update
    nm = NotificationModel.find(params[:id])
    nm.update(:message =>params_model) ##fix handle error
    for i in params_itens[:items] do
      # raise ActiveModel::AssociationNotFoundError if nm.wi_update_or_create(i).nil?
      raise ActiveModel::AssociationNotFoundError if !nm.update_item(i)
    end

    for i in params_descarted[:deleted] do
      nm.delete_item(i)
    end

    if nm.save()
      return render json: nm, status: :ok
    else
      return render json: nm.errors, status: :unprocessable_entity
    end
  end

  def destroy
    NotificationModel.delete(params[:id])
  end

  private
  def params_model
    params.require(:message)
  end

  # private
  # def listen_id
  #   params.require(:model).permit(:listen_id)
  # end

  private
  def params_itens
    params.require(:wanted_items).permit(items:[ :id, :var_name, :url, :wanted_value,
                                                  :path, :islast])
  end

  private
  def params_descarted
    params.require(:descarted_items).permit(deleted:[ :id, :var_name, :url, :wanted_value,
                                                 :path, :islast])
  end
end
