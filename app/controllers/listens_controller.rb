class ListensController < ApplicationController
  def index
    render json: Listen.all
  end

  def create
    listen = Listen.new(listen_params)
    listen.site = Site.find(params[:site][:id])
    # item = Item.new(item_params)
    # item.listen = listen
    # if item.save
    # listen.item = item
    if listen.save
      render json: listen, status: :created
    else
      render json: listen.errors, status: :unprocessable_entity
    end

    # else
    #   render json: item.errors, status: :unprocessable_entity
    # end
  end

  def update
    listen = Listen.find(params[:id])
    listen.update_attributes!()
    render json: listen
  end

  def destroy
    Listen.destroy_all(params[:id])
  end

  private
  def listen_params
    params.require(:listen).permit(:name, :url, :searched_item)
  end

  private
  def item_params
    params.require(:item).permit(:locator, :indentifier)
  end

  # private
  # def site_params
  #   params.require(:site).permit(:id)
  #
  # end
end
