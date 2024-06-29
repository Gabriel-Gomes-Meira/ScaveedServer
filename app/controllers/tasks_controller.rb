class TasksController < ApplicationController
  def index
    listens_joins = ModelTask.joins(:listen).select('model_tasks.*, listens.name as listen_name, listens.id as listen_id')
    crons_joins = ModelTask.joins(:cron).select('model_tasks.*, crons.name as cron_name, crons.id as cron_id')    
    crons_joins = crons_joins.group_by(&:id)
    crons_joins = crons_joins.map do |key, value|
      preValue = value
      value = value.map do |v| 
        v.attributes.except('cron_name', 'cron_id')
      end
      value[0][:crons] = preValue.map do |v|
        {id: v[:cron_id], name: v[:cron_name]}
      end
      value[0][:crons_names] = value[0][:crons].map { |v| v[:name] }.join(', ')
      value[0]
    end
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
    if listen.nil? && crons.length == 0
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
        if crons.length > 0
          for cron in crons
            cron.model_task_id = model_task.id
            cron.save()
          end
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
                      :preset_content => model_task.preset_content,
                      :params => params[:task][:params]
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
      if crons.length > 0
        Cron.where(model_task_id: model_task.id).each do |cron|
          cron.model_task_id = nil
          cron.save()
        end
        for cron in crons
          cron.model_task_id = model_task.id
          cron.save()
        end        
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
    Cron.where(model_task_id: params[:id]).each do |cron|
      cron.model_task_id = nil
      cron.save()
    end
    qtdd = ModelTask.destroy(params[:id])
    render json:{:message => "Were deleteds #{qtdd} documents!"}, status: :ok
  end

  def dequeue
    qtdd = QueuedTask.destroy(params[:id])
    render json:{:message => "Were deleteds #{qtdd} documents!"}, status: :ok
  end

  private
  def params_task
    params.require(:task).permit(:file_name, :content, :preset_content, :params)
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
  def crons
    if params.has_key?(:cron) && params[:cron][:ids]
      crons = []
      for id in params[:cron][:ids]
        crons.push Cron.find(id)
      end
      return crons
    else
      nil
    end
  end


end
