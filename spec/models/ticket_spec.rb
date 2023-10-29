require "rails_helper"

RSpec.describe Ticket, type: :model do
  describe "relationships" do
    it { should have_many :ticket_employees }
    it { should have_many(:employees).through(:ticket_employees) }
  end
end