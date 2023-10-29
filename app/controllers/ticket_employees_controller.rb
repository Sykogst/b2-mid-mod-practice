class TicketEmployeesController < ApplicationController
  def create
    @ticket = Ticket.find(params[:ticket])
    @employee = Employee.find(params[:employee_id])
    TicketEmployee.create!(ticket: @ticket, employee: @employee)

    redirect_to "/employees/#{@employee.id}"
  end
end