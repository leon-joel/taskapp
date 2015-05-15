class TasksController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.create(task_params)
    redirect_to project_path(@project.id)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to project_path(params[:project_id])
  end

  def toggle
    render nothing: true    # 「templateを使わない」という指定。
                            # これをしておかないと、ActionView::MissingTemplate というエラーが発生する。（ブラウザ上には表示されない）

    @task = Task.find(params[:id])
    @task.done = !@task.done
    @task.save
  end

  private
    # 外部で設定してもよいパラメータを明示する ※セキュリティ強化のためRails4から？必要になった
    # ※フォームからこれ以外のパラメータが渡されてきてもフィルタリングに引っかかるのかな？
    def task_params
      params[:task].permit(:title)
    end


end
