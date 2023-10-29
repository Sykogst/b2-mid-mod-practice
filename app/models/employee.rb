class Employee < ApplicationRecord
  belongs_to :department
  has_many :ticket_employees
  has_many :tickets, through: :ticket_employees


  def tickets_sorted
    self.tickets.order(age: :desc)
  end

  # def self.employee_tickets(employee_id)
  #   joins(:ticket_employees).where("employee_id = ?", employee_id).pluck(:ticket_id)
  # end

  # def self.shared_tickets(employee_id)
  #   select("employees.*").joins(:ticket_employees).where(ticket_employees: {ticket_id: employee_tickets(employee_id)}).distinct.where.not("employee_id = ?", employee_id)
  # end

  def employee_tickets
    self.class.joins(:ticket_employees).pluck(:ticket_id)
  end

  def shared_tickets
    self.class.select("employees.*").joins(:ticket_employees).where(ticket_employees: { ticket_id: employee_tickets }).distinct.where.not("employee_id = ?", self.id)
  end
end