class Restaurant < ActiveRecord::Base

  has_many :reservations
  has_many :dine_outs
  has_many :food_items

  before_save {self.name = name.downcase}
  before_create :create_remember_token
  validates :name, presence: true, uniqueness: {case_sensitive:false}
  validates :owner, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :sundayOpen, presence: true
  validates :sundayClose, presence: true
  validates :mondayOpen, presence: true
  validates :mondayClose, presence: true
  validates :tuesdayOpen, presence: true
  validates :tuesdayClose, presence: true
  validates :wednesdayOpen, presence: true
  validates :wednesdayClose, presence: true
  validates :thursdayOpen, presence: true
  validates :thursdayClose, presence: true
  validates :fridayOpen, presence: true
  validates :fridayClose, presence: true
  validates :saturdayOpen, presence: true
  validates :saturdayClose, presence: true
  validates :reserveCap, presence: true

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
