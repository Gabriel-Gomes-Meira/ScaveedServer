class TaskController < ApplicationController
  def index
    model_tasks = ModelTask.all
    return render json: model_tasks, status: :ok
  end
  
  def all_queued
    tasks = Task.order_by updated_at: :asc
    render json: tasks, status: :ok
  end
  
  def create

    # return render json: ENV['tasks_scripts_path'], status: :ok
    listen = param_listen
    if listen.nil?
      task = Task.new(params_task)
      if task.save
        render json:task, status: :created
      else
        return render json: task.errors,
                      status: :unprocessable_entity
      end
    else
      model_task = ModelTask.new(params_task)
      model_task.listen = listen
      if model_task.save()
        render json: [listen,model_task], status: :created
      else
        render json: {"Task_Errors":model_task.errors},
               status: :unprocessable_entity
      end
    end
  end

  def update
    model_task = ModelTask.find(params[:id])
    model_task.update_attributes(params_task)
    model_task.listen = param_listen
    if model_task.save()
      render json: [model_task], status: :ok
    else
      render json: {"Task_Errors":model_task.errors},
             status: :unprocessable_entity
    end
  end

  def destroy
    qtdd = ModelTask.destroy_all({:_id => params[:id]})
    render json:{:message => "Were deleteds #{qtdd} documents!"}, status: :ok
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
