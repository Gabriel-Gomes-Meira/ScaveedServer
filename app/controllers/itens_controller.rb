class ItensController < ApplicationController
  def index
    render json: Item.all
  end

  def create
    item = Item.new(listen_params)
    item.listen = Listen.find(params[:listen][:id])

    if item.save
      render json: item, status: :created
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Item.destroy_all
  end

  private
  def item_params
    params.require(:item).permit(:locator, :indentifer)
  end
end
