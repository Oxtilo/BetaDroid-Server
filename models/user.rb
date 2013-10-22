class User < ActiveRecord::Base
  validates :name, :email, :uid, presence: true
  before_save :build_access_token

  def build_access_token
    if self.access_token.nil?
      token = ""
      while true
        token = SecureRandom.hex(32)
        break if User.where(access_token: token).count == 0
      end

      self.access_token = token
    end
  end

  def self.new_from_omniauth(omniauth)
    user = User.new
    user.uid   = omniauth["uid"]
    user.name  = omniauth["info"]["name"]
    user.email = omniauth["info"]["email"]
    user.save
    user
  end

  def admin?
    ENV["ADMIN_EMAIL"] == self.email
  end

  def accepted?
    admin? || active
  end
end
