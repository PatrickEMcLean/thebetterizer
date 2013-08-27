# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
role_admin = Role.find_or_create_by_key_and_label(key: "admin", label: "Admin")
role_coach = Role.find_or_create_by_key_and_label(key: "coach", label: "Coach")

scott_admin = User.where(
  provider: "google_oauth2",
  uid: "104542683808519361711").first


unless scott_admin
  scott_admin = User.create(
    provider: "google_oath2",
    uid: "104542683808519361711",
    name: "Scott Helm",
    email: "helm.scott@gmail.com",
    image: "https://lh4.googleusercontent.com/-htHglKVHpO0/AAAAAAAAAAI/AAAAAAAAAWU/pkq-oyAzbN4/photo.jpg")
end

patrick_admin = User.where(provider: "google_oauth2", uid: "02010383447562053979").first


unless patrick_admin
  patrick_admin = User.create(
    provider: "google_oath2",
    uid: "02010383447562053979",
    name: "Patrick McLean",
    email: "patrickemclean@gmail.com",
    image: "https://lh5.googleusercontent.com/-Q0ND5O1iOKQ/AAAAAAAAAAI/AAAAAAAAAOs/hc-0eF_zIj0/photo.jpg")
end

scott_admin.roles << role_admin
patrick_admin.roles << role_admin

