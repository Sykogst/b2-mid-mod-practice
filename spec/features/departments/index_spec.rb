require "rails_helper"

RSpec.describe "departments index", type: :feature do
  before(:each) do
    @department_1 = Department.create!(name: "Accounting", floor: "Middle")
    @department_2 = Department.create!(name: "IT", floor: "Basement")

    @employee_1 = Employee.create!(name: "Sam", level: 2, department: @department_1)
    @employee_2 = Employee.create!(name: "Max", level: 1, department: @department_1)
    @employee_3 = Employee.create!(name: "Ben", level: 3, department: @department_2)
    @employee_4 = Employee.create!(name: "Sally", level: 4, department: @department_2)
  end

  describe 'When user visits departments index page, they see department information' do
    it 'They see departments name and floor' do
      visit "/departments"

      within "#dept-#{@department_1.id}" do
        expect(page).to have_content(@department_1.name)
        expect(page).to have_content(@department_1.floor)
      end

      within "#dept-#{@department_2.id}" do
        expect(page).to have_content(@department_2.name)
        expect(page).to have_content(@department_2.floor)
      end
    end

    it 'They see departments list of employees' do
      visit "/departments"

      within "#dept-#{@department_1.id}" do
        expect(page).to have_content("Employees: #{@employee_1.name} #{@employee_2.name}")
      end

      within "#dept-#{@department_2.id}" do
        expect(page).to have_content("Employees: #{@employee_3.name} #{@employee_4.name}")
      end
    end
  end

end
# As a user,
# When I visit the Department index page,
# I see each department's name and floor
# And underneath each department, I can see the names of all of its employees