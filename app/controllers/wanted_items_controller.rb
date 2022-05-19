class WantedItemsController < ApplicationController

  ## talvez seja mais interessante desfazer desse controller, e passar
  ## todo controle pro notification controller.
  def index
    render json: WantedItem.all
  end

  def update
    # return render json: params
    ids = params[:id].split(",")
    corrently_saved = []
    for i in params[:items]
      item = WantedItem.find({:_id => ids.shift})
      if item.update_attributes(i)
        corrently_saved.push(item)
      else
        render json: item.errors, status: :unprocessable_entity
      end
    end
    render json: corrently_saved, status: :ok
  end

  def destroy
    WantedItem.destroy_all({:_id => params[:id]})
  end

  # private
  # def params_items
  #   params.require(:items).permit([:pre_text, :url, :wanted_value,
  #                                                :indentifier, recursive_path: [], distinguer: [:is_last]])
  # end
end
