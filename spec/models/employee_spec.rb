require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it { should belong_to :department }
    it { should have_many :ticket_employees }
    it { should have_many(:tickets), through:(:ticket_employees) }
  end
end