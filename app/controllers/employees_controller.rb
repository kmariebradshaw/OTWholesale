class EmployeesController < ApplicationController
  def new 
    @employee = Employee.new()
	end 
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to '/employees'
    else
      render 'new'
    end 
  end 
  def show
    @employee = Employee.find(params[:id]) 
  end 
  def index
    @employees = Employee.all 
  end 
  def edit
    @employee = Employee.find(params[:id])
  end
  def update
    @employee = Employee.find(params[:id]) 
     if @employee.update(employee_params)
       
      redirect_to "/employees"
    else
      render :edit
    end
  end 
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to "/employees"
  end
  private 
  def employee_params
      params.require(:employee).permit(:name, :email)
  end 
end

