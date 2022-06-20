class NotificationModelController < ApplicationController
  def index
    render json: NotificationModel.all
  end

  def create
    nm = NotificationModel.new(params_message)
    listen = Listen.find(params[:listen][:id])
    nm.listen = listen
    for item in params_itens[:wanted_items] do
      # return render json:nm.wi_update_or_create(item),status: :temporary_redirect
      if !nm.wi_update_or_create(item)
        return render json: nm.errors, status: :unprocessable_entity
      end
    end

    if nm.save()
      return render json: nm, status: :created
    else
      return render json: nm.errors, status: :unprocessable_entity
    end
  end

  def update
    nm = NotificationModel.find(:_id => params[:id])
    for i in params_itens[:wanted_items] do
      raise ActiveModel::AssociationNotFoundError if nm.wi_update_or_create(i).nil?
    end

    if params[:model][:message]
      nm.update_attributes(params_message)
    end

    if nm.save()
      return render json: nm, status: :ok
    else
      return render json: nm.errors, status: :unprocessable_entity
    end
  end

  def destroy
    NotificationModel.destroy_all({:_id => params[:id]})
  end

  private
  def params_message
    params.require(:model).permit(:message)
  end

  private
  def params_itens
    params.require(:model).permit(wanted_items: [:id, :var_name, :url, :wanted_value,
                                                 :path, distinguer: [:is_last]])
  end
end
