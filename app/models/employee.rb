class Employee < ApplicationRecord
  belongs_to :department
  has_many :ticket_employees
  has_many :tickets, through: :ticket_employees

  def tickets_sorted
    self.tickets.order(age: :desc)
  end
end