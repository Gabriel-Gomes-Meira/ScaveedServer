class SitesController < ApplicationController
  def index
    render json: Site.all
  end

  def create
    site = Site.new(site_params)
    if site.save
      render json: site, status: :created
    else
      render json: site.errors, status: :unprocessable_entity
    end
  end

  def update
    site = Site.find(params[:id])

    if site.update(site_params)     #.update_attributes(site_params)
      render json: site, status: :ok
    else
      render json: site.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Site.destroy_all({:id => params[:id]})
  end

  private
  def site_params
    params.require(:site).permit(:name, :url)
  end
end