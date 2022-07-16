class ReportsController < ApplicationController
  def index
    clients = ModelTask.mongo_client.with()
    render json: clients[:reports].find({}).sort(updated_at:-1),
           status: :ok
  end
end
