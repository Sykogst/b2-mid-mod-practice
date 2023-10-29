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
  end

  describe 'When a user visits employee show page /employees/:id' do
    it 'They see employee name and department' do
      visit "/employees/#{@employee_1.id}"

      expect(page).to have_content(@employee_1.name)
      expect(page).to have_content(@employee_1.department.name)
    end

    it 'They see employee name and department' do
      @employee_1.tickets << @ticket_1
      @employee_1.tickets << @ticket_2
      @employee_1.tickets << @ticket_3

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

  describe 'When a user visits employee show page, they can add a ticket to this employee' do
    it 'They do not see any tickets not assigned to this employee' do
      @employee_1.tickets << @ticket_1

      visit "/employees/#{@employee_1.id}"

      expect(page).to have_content(@ticket_1.subject)
      expect(page).to_not have_content(@ticket_2.subject)
      expect(page).to_not have_content(@ticket_3.subject)
    end

    it 'They see a form to add a ticket to this employee (by id)' do
      visit "/employees/#{@employee_1.id}"

      expect(page).to have_selector(:link_or_button, "Add Ticket")
    end

    it "They fill in the form with a ticket id, clicks button, redirects back to show page, and see ticket subject" do
      visit "/employees/#{@employee_1.id}"

      fill_in("Ticket", with: @ticket_1.id)
      click_button("Add Ticket")

      expect(current_path).to eq("/employees/#{@employee_1.id}")
      
      within "#ticket-#{@ticket_1.id}" do
        expect(page).to have_content(@ticket_1.subject)
      end
    end
  end

  describe 'When user visits employee show page they see more information' do
    it 'They see employees level' do
      visit "/employees/#{@employee_1.id}"

      expect(page).to have_content(@employee_1.level)
    end

    it 'They see a unique list of all other employees that this employee shares tickets with' do
      @employee_1.tickets << @ticket_1
      @employee_1.tickets << @ticket_2

      @employee_2.tickets << @ticket_1
      @employee_3.tickets << @ticket_1
      @employee_3.tickets << @ticket_2

      visit "/employees/#{@employee_1.id}"
      
      expect(page).to have_content(@employee_2.name)
      expect(page).to have_content(@employee_3.name)
    end
  end

end

# As a user,
# When I visit an employee's show page
# I see that employees name and level
# and I see a unique list of all the other employees that this employee shares tickets with

# # As a user,
# # When I visit the employee show page,
# # I do not see any tickets listed that are not assigned to the employee
# # and I see a form to add a ticket to this employee.
# # When I fill in the form with the id of a ticket that already exists in the database
# # and I click submit
# # Then I am redirected back to that employees show page
# # and I see the ticket's subject now listed.

# (you do not have to test for sad path, for example if the id does not match an existing ticket.)

# As a user,
# When I visit the Employee show page,
# I see the employee's name, their department,
# and a list of all of their tickets from oldest to newest.
# I also see the oldest ticket assigned to the employee listed separately.