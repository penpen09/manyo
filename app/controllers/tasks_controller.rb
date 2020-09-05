class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(limit_date: :asc)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :asc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end

    if params[:search].present?
      if params[:title].present? && params[:status].present?
        @tasks = Task.title_search(params[:title]).status_search(params[:status])
      elsif params[:title].present?
        @tasks = Task.title_search(params[:title])
      elsif params[:status].present?
        @tasks = Task.status_search(params[:status])
      else
        @tasks = Task.all.order(created_at: :desc)
      end
    end
  end


  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice:"task追加"
      else
        render :new
      end
    end
  end
  def show
  end
  def edit
  end
  def update
    @task = Task.find(params[:id])
    if params[:back]
      render  :edit
    else
      if @task.update(task_params)
        redirect_to tasks_path, notice:"編集しました"
      else
        render :edit
      end
    end
  end
  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end
  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"削除しました"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content,:limit_date, :sort_expired, :status, :priority)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
