class LogsController < ApplicationController
    def index
        render json: Log.all
    end
end