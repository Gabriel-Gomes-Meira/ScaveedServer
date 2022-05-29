class TaskController < ApplicationController
  def create

    # return render json: ENV['tasks_scripts_path'], status: :ok
    task = Task.new(params_task)
    listen = param_listen
    if listen.nil?
      if task.save
        if task.content.length > 0
          write_file_script(task.file_name, task.content)
        end
        render json:task, status: :created
      else
        return render json: task.errors,
                      status: :unprocessable_entity
      end
    else
      task.with(collection:"model_task") do |mt|
        listen.model_task = mt
        if write_file_script(mt.file_name, mt.content) && mt.save()
          render json: [listen,mt], status: :created
        else
          render json: {"Task_Errors":task.errors,
                        "Listen_Erros":listen.errors},
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    Task.with(collection: "model_task") do |klass|
      doc = klass.find({:_id => params[:id]})

      if doc.destroy
        render json: doc, status: :ok
      else
        render json: doc, status: :not_found
      end
    end
    # Task.remove_from_queue(id)
    # Mongoid::Errors::DocumentNotFound, tratamento deve ser aplicado
  end

  private
  def params_task
    params.require(:task).permit(:file_name, content: [])
  end

  private
  def param_listen
    if params.has_key?(:listen) && params[:listen].has_key?(:id)
      Listen.find({:_id => params[:listen][:id]})
    else
      nil
    end
  end

  private
  def write_file_script(filename, content = [])
    f = File.new("#{ENV['tasks_scripts_path']+filename}", "w")
    f.write(content.join(""))
    f.close
    true
    # render json: {:fle => f, :pa1 => filename, :pa2 => content}
  end

end
