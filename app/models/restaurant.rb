class Restaurant < ActiveRecord::Base

  has_many :reservations
  has_many :dine_outs
  has_many :menus

  before_save {self.name = name.downcase}
  before_create :create_remember_token
  validates :name, presence: true, uniqueness: {case_sensitive:false}
  validates :owner, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  has_secure_password

  def Restaurant.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Restaurant.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Restaurant.digest(Restaurant.new_remember_token)
    end
end
