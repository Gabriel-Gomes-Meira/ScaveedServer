class CronsController < ApplicationController
    def index
      render json: Cron.all
    end
  
    def create
      cron = Cron.new(cron_params)
      if cron.save
        render json: cron, status: :created
      else
        render json: cron.errors, status: :unprocessable_entity
      end
    end
  
    def update
      cron = Cron.find(params[:id])
  
      if cron.update(cron_params)     #.update_attributes(cron_params)
        render json: cron, status: :ok
      else
        render json: cron.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      Cron.destroy(params[:id])
    end
  
    private
    def cron_params
      params.require(:cron).permit(:name, :interval, :next_run)
    end
end