class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :email, :image

  has_and_belongs_to_many :roles
  has_many :works

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.image = auth["info"]["image"]

    end
  end

  def has_role?(role_name)
    (roles.map &:key).select { |k| k == role_name }.size > 0
  end

  def highest_role
    has_role?("admin") ? "admin" :
      has_role?("coach") ? "coach" : "user"
  end

end
