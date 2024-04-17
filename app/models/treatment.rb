class Treatment < ApplicationRecord
  has_many :hospital_treatments, dependent: :destroy
  has_many :hospitals, through: :hospital_treatments
  has_many :doctor, through: :hospital_treatments
end
