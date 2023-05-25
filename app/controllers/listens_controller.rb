class ListensController < ApplicationController
  def index
    render json: Listen.all
  end

  def create
    listen = Listen.new(listen_params)
    
    if listen.save
      render json: listen, status: :created
    else
      render json: listen.errors, status: :unprocessable_entity
    end
  end

  def update
    listen = Listen.find(params[:id])
    listen.update(listen_params)
    render json: listen 
  end

  def destroy
    Listen.destroy(params[:id])
  end

  private
  def listen_params
    params.require(:listen).permit(:name, :url, :element_indentifier, :site_id)
  end
end