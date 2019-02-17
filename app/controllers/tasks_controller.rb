class TasksController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
  end

  def new
    @tasks = Task.new
  end

  def create
    @tasks = Task.new(task_params)
    
    if @tasks.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @tasks.update(task_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tasks.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_message
    @tasks = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :title, :status)
  end
end
