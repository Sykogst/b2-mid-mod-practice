class Ticket < ApplicationRecord
  has_many :ticket_employees
  has_many :employees, through: :ticket_employees
end