class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task= Task.new(task_params)

    if @task.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
    if @task.user != current_user
      redirect_to @link, notice: "You do not have permission to edit this task."
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    if @task.user == current_user
      @task.destroy
    else
      redirect_to @user, notice: "You do not have permission to remove this task."
    end
  end

  

  private

  

  def task_params
    params.require(:task).permit(:name, :description, :duedate, :completed, :horse_id)
  end

end

