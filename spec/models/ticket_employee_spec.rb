require "rails_helper"

RSpec.describe TicketEmployee, type: :model do
  describe "relationships" do
    it {should belong_to :ticket}
    it {should belong_to :employee}
  end
end