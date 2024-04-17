class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum :user_type, { Admin: 0, Patient: 1, Doctor: 2 }
  has_many :treatments
  has_many :hospitals
  has_many :patient_requests, class_name: 'Request', foreign_key: 'patient_id'
  has_many :hospital_treatments
  has_many :treatments, through: :hospital_treatments
  has_many :doctor_requests, through: :hospital_treatments, source: :doctor
  def admin?
    user_type == 'Admin'
  end

  def patient?
    user_type == 'Patient'
  end

  def doctor?
    user_type == 'Doctor'
  end

  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }
  def doctor_requests
    hospital_treatments_ids = HospitalTreatment.where(doctor: self).pluck(:id)
    Request.where(hospital_treatment_id: hospital_treatments_ids)
  end
end
