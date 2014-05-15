class Restaurant < ActiveRecord::Base

  validates :name, presence: true
  validates :owner, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  has_secure_password
end
