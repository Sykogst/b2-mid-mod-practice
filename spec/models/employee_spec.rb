require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it { should belong_to :department }
    it { should have_many :ticket_employees }
    it { should have_many(:tickets), through:(:ticket_employees) }
  end

  before(:each) do
    @department_1 = Department.create!(name: "Accounting", floor: "Middle")
    @department_2 = Department.create!(name: "IT", floor: "Basement")

    @employee_1 = Employee.create!(name: "Sam", level: 2, department: @department_1)
    @employee_2 = Employee.create!(name: "Max", level: 1, department: @department_1)
    @employee_3 = Employee.create!(name: "Ben", level: 3, department: @department_2)
    @employee_4 = Employee.create!(name: "Sally", level: 4, department: @department_2)

    @ticket_1 = Ticket.create!(subject: "Do timesheet", age: 2)
    @ticket_2 = Ticket.create!(subject: "Fax things", age: 5)
    @ticket_3 = Ticket.create!(subject: "Check email", age: 1)

    @employee_1.tickets << @ticket_1
    @employee_1.tickets << @ticket_2
    @employee_1.tickets << @ticket_3
  end

  describe 'instance methods' do
   describe '#tickets_sorted' do
     it 'list of tickets from oldest to newest' do
       expect(@employee_1.tickets_sorted).to eq([@ticket_2, @ticket_1, @ticket_3])
     end
   end
  end
end