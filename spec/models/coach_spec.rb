require 'spec_helper'

describe Coach do
  describe "work" do
    it "should have a list of work assigned to it" do
      user = User.create!(name: "great")
      customer = User.create!(name: "customer")
      coach = Coach.create!(user_id: user.id)

      work = Work.create!(user_id: customer.id, coach_id: coach.id)

      expect(coach.works.size).to eq(1)
    end
  end
end
