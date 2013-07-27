require 'spec_helper'

describe Role do
  it "should list users associated with the role and vice versa" do
    user = User.create!(name: "awesome")
    role = Role.create!(key: "test", label: "test")

    user.roles << role

    user.save
    expect(user.roles.size).to eq(1)
    expect(user.roles.first).to eq(role)
    expect(role.users.size).to eq(1)
    expect(role.users.first).to eq(user)
  end
end
