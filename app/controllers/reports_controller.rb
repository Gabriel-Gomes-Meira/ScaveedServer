class ReportsController < ApplicationController
  def index
    client = Listen.mongo_client.with()
    render json: client[:reports].find({}),
           status: :ok
  end

  def clean
    client = Listen.mongo_client.with()
    
    report = client[:reports].find(:_id  => BSON::ObjectId(params[:id])).first
    count = report[:registers].length
    client[:reports].update_one({:_id => BSON::ObjectId(params[:id])}, "$set" => {
                                                                      :registers => []
                                                                    })


    render json: {:response =>
                    "#{count} relatórios foram deletados nessa operação!"},
                  status: :ok
  end
end
