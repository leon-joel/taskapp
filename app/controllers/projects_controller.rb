class ProjectsController < ApplicationController

  # 共通処理をまとめることが出来る
  # 指定されたactionの頭で set_projectメソッドが実行される。
  # ただ、アクションメソッドの見通しが悪くなるような気がする。
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    # @変数は view で使えるようになる
    # @project = Project.find(params[:id])  # before_actionで共通化
    # params は URLで渡ってきた値。どのシンボルが渡ってくるかは rake routes をみれば分かる
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)  # project_paramsというprivateメソッドを呼び出し  ※これはパターン化してるから必ずこのやり方で

    # save時に validation が発動する ※validationルールは model に定義してある
    if @project.save
      # validation＆保存が成功した場合
      redirect_to projects_path
    else
      # validation or 保存に失敗した場合
      # エラー内容が @project.errors に格納され
      render 'new'  # new に戻る
    end
  end

  # Editボタンを押した時に呼ばれる。Editフォームに渡すprojectを検索する。
  def edit
    # @project = Project.find(params[:id])    # before_actionで共通化した
  end

  # Editフォームでupdateボタンを押した時に呼ばれる。(new-create でいうと、createに相当する)
  def update
    # @project = Project.find(params[:id])    # before_actionで共通化した

    if @project.update(project_params)
      # validation＆保存が成功した場合
      redirect_to projects_path
    else
      # validation or 保存に失敗した場合
      # エラー内容が @project.errors に格納され
      render 'edit'  # edit に戻る
    end
  end

  def destroy
    # @project = Project.find(params[:id])    # before_actionで共通化した
    @project.destroy
    redirect_to projects_path
  end

  private
    # 外部で設定してもよいパラメータを明示する ※セキュリティ強化のためRails4から？必要になった
    # ※フォームからこれ以外のパラメータが渡されてきてもフィルタリングに引っかかるのかな？
    def project_params
      params[:project].permit(:title)
    end

    def set_project
      # @変数は view で使えるようになる
      @project = Project.find(params[:id])
    end
end
