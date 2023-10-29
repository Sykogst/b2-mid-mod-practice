require "rails_helper"

RSpec.describe "employeers show", type: :feature do
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

  describe 'When a user visits employee show page /employees/:id' do
    it 'They see employee name and department' do
      visit "/employees/#{@employee_1.id}"
save_and_open_page
      expect(page).to have_content(@employee_1.name)
      expect(page).to have_content(@employee_1.department.name)
    end

    it 'They see employee name and department' do
      visit "/employees/#{@employee_1.id}"

      oldest = find("#ticket-#{@ticket_2.id}")
      mid = find("#ticket-#{@ticket_1.id}")
      newest = find("#ticket-#{@ticket_3.id}")

      expect(oldest).to appear_before(mid)
      expect(mid).to appear_before(newest)

      within "#ticket-#{@ticket_1.id}" do
        expect(page).to have_content(@ticket_1.subject)
      end

      within "#ticket-#{@ticket_2.id}" do
        expect(page).to have_content(@ticket_2.subject)
      end

      within "#ticket-#{@ticket_3.id}" do
        expect(page).to have_content(@ticket_3.subject)
      end
    end
  end
end

# As a user,
# When I visit the Employee show page,
# I see the employee's name, their department,
# and a list of all of their tickets from oldest to newest.
# I also see the oldest ticket assigned to the employee listed separately.