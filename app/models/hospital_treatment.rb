class HospitalTreatment < ApplicationRecord
  belongs_to :hospital
  belongs_to :treatment, optional: true
  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  has_many :request, dependent: :destroy
end
