class TaskController < ApplicationController
  def index
    model_tasks = Task.with(collection:"model_task") do |mt|
      mt.all
    end
    render json: model_tasks, status: :ok
  end
  
  def all_queued
    tasks = Task.order_by updated_at: :asc
    render json: tasks, status: :ok
  end
  
  def create

    # return render json: ENV['tasks_scripts_path'], status: :ok
    task = Task.new(params_task)
    listen = param_listen
    if listen.nil?
      if task.save
        render json:task, status: :created
      else
        return render json: task.errors,
                      status: :unprocessable_entity
      end
    else
      task.with(collection:"model_task") do |mt|
        if mt.save()
          render json: [listen,mt], status: :created
        else
          render json: {"Task_Errors":task.errors,
                        "Listen_Errors":listen.errors},
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy


    doc = Task.with(collection: "model_task") do |mt|
      mt.find_by(:_id => {:oid => params[:id]})
    end
    render json: doc
    # render json:{:message => "Were deleteds #{qtdd} documents!"}, status: :ok
    # Task.remove_from_queue(id)
    # Mongoid::Errors::DocumentNotFound, tratamento deve ser aplicado
  end

  def dequeue
    qtdd = Task.destroy_all({:_id => params[:id]})
    render json:{:message => "Were deleteds #{qtdd} documents!"}, status: :ok
  end

  private
  def params_task
    params.require(:task).permit(:file_name, content: [])
  end

  private
  def param_listen
    if params.has_key?(:listen) && params[:listen][:id]
      Listen.find({:_id => params[:listen][:id]})
    else
      nil
    end
  end

end
