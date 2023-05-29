class LogsController < ApplicationController
    def index
        logs = Log.paginate(page: params[:page], per_page: params[:per_page]).order('at DESC')
        render json: {
            items: logs,
                pagination: {
                total_pages: logs.total_pages,
                total_records: logs.total_entries
            }
        }    
    end
end