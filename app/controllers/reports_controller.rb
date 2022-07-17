class ReportsController < ApplicationController
  def index
    client = Listen.mongo_client.with()
    render json: client[:reports].find({}),
           status: :ok
  end

  def clean
    client = Listen.mongo_client.with(collection:"reports")
    
    report = client[:reports].find(:_id == params[:id]).first
    count = report[:registers].length
    client[:reports].find_one_and_update(:_id == params[:id],
                                         "$set" => {
                                           :registers => []
                                         })


    render json: {:response =>
                    "#{count} relatórios foram deletados nessa operação!"},
                  status: :ok
  end
end
