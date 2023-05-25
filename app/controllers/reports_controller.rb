class ReportsController < ApplicationController
  def index
    resp = []
    for l in Listen.select("name as listen_name, id")
      resp.push(l.attributes)
      resp.last[:registers] = Report.where(listen_id: l.id)
    end
    
    render json: resp,
           status: :ok
  end

  def clean

    reports = Report.where(listen_id: params[:id])
    count = reports.length
    reports.destroy_all


    render json: {:response =>
                    "#{count} relatórios foram deletados nessa operação!"},
           status: :ok
  end
end
