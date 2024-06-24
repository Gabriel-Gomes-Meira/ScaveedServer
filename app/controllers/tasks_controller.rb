class TasksController < ApplicationController
  def index
    listens_joins = ModelTask.joins(:listen).select('model_tasks.*, listens.name as listen_name, listens.id as listen_id')
    crons_joins = ModelTask.joins(:cron).select('model_tasks.*, crons.name as cron_name, crons.id as cron_id')
    return render json: listens_joins+crons_joins, status: :ok
  end

  def all_queued
    render json: QueuedTask.all, status: :ok
  end

  def history_tasks
    logs = LogTask.paginate(page: params[:page], per_page: params[:per_page]).order('terminated_at DESC')
    render json: {
      items: logs,
      pagination: {
        total_pages: logs.total_pages,
        total_records: logs.total_entries
      }
    }    
  end

  def create

    # return render json: ENV['tasks_scripts_path'], status: :ok
    listen = param_listen
    cron = param_cron_task
    if listen.nil? && cron.nil?
      task = QueuedTask.new(params_task)
      if task.save
        render json:task, status: :created
      else
        return render json: task.errors,
                      status: :unprocessable_entity
      end
    else
      model_task = ModelTask.new(params_task)
      if model_task.save()
        if cron
          cron.model_task_id = model_task.id
          cron.save()
        end
        if listen
          listen.model_task_id = model_task.id
          listen.save()
        end
        render json: [listen,cron,model_task], status: :created
      else
        render json: {"Task_Errors":model_task.errors},
               status: :unprocessable_entity
      end
    end
  end

  def add_queue
    model_task = ModelTask.find(params[:id])
    task = QueuedTask.new({
                      :content => model_task.content,
                      :file_name => model_task.file_name,
                      :preset_content => model_task.preset_content
                    })
    if task.save
      render json:task, status: :created
    else
      return render json: task.errors,
                    status: :unprocessable_entity
    end
  end

  def update
    model_task = ModelTask.find(params[:id])

    if model_task.update(params_task)
      if param_listen 
        listen = param_listen
        listen.model_task_id = model_task.id
        listen.save()
      end
      if param_cron_task
        cron = param_cron_task
        cron.model_task_id = model_task.id
        cron.save()
      end
      render json: [model_task], status: :ok
    else
      render json: {"Task_Errors":model_task.errors},
             status: :unprocessable_entity
    end
  end

  def fix_queue
    task = QueuedTask.find(params[:id])

    if task.update(params_task) && task[:state] == 0
      task.save
      render json: task, status: :ok
    else
      render json: [task.errors, task[:state] == 0] , status: :unprocessable_entity
    end
  end

  def destroy
    qtdd = ModelTask.destroy(params[:id])
    render json:{:message => "Were deleteds #{qtdd} documents!"}, status: :ok
  end

  def dequeue
    qtdd = QueuedTask.destroy(params[:id])
    render json:{:message => "Were deleteds #{qtdd} documents!"}, status: :ok
  end

  private
  def params_task
    params.require(:task).permit(:file_name, :content, :preset_content)
  end

  private
  def param_listen
    if params.has_key?(:listen) && params[:listen][:id]
      Listen.find(params[:listen][:id])
    else
      nil
    end
  end

  private
  def param_cron_task
    if params.has_key?(:cron) && params[:cron][:id]
      Cron.find(params[:cron][:id])
    else
      nil
    end
  end


end
