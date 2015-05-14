class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    # @変数は view で使えるようになる
    @project = Project.find(params[:id])
    # params は URLで渡ってきた値。どのシンボルが渡ってくるかは rake routes をみれば分かる
  end

  def new
    @project = Project.new
    
  end
end
