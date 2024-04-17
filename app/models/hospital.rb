class Hospital < ApplicationRecord
  has_many :hospital_treatments, dependent: :destroy
  has_many :treatments, through: :hospital_treatments
  has_many :doctor, through: :hospital_treatments
  validates :name, presence: true, uniqueness: true
end
