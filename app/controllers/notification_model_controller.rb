class NotificationModelController < ApplicationController
  def index
    render json: NotificationModel.all
  end

  def create
    nm = NotificationModel.new(params_message)
    listen = Listen.find(params[:listen][:id])
    nm.listen = listen
    # return render json: notification_params
    for item in params_itens[:wanted_items] do
      wi = WantedItem.new(item)
      wi.notification_model = nm
      if wi.save
        # nm.wanted_items.push(wi)
      else
        return render json: wi.errors, status: :unprocessable_entity
      end
    end

    if nm.save()
      listen.notification_model = nm
      listen.save
      return render json: nm, status: :created
    else
      return render json: nm.errors, status: :unprocessable_entity
    end
  end

  def update

  end

  def destroy
    NotificationModel.destroy_all(params[:id])
  end

  # private
  # def listen_param
  #   params.require(:listen).permit(:id)
  # end

  private
  def params_message
    params.require(:model).permit(:remain_message)
  end

  private
  def params_itens
    params.require(:model).permit(wanted_items: [:pre_text, :url, :wanted_value,
                                                 :indentifier, recursive_path: [], distinguer: [:is_last]])
  end
end
