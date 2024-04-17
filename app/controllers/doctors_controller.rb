class DoctorsController < ApplicationController
  def index

    @hospital = Hospital.find(params[:hospital_id])
    @doctor_added = @hospital.doctor.uniq
    @doctor_not_added = User.all.where(user_type: 'Doctor')
    @doctor_not_added = @doctor_not_added.all.where.not(id: @doctor_added.pluck(:id))
  end

  def add_doctor
    @hospital = Hospital.find(params[:hospital_id])
    @user = User.find(params[:doctor_id])
    HospitalTreatment.create!(hospital_id: params[:hospital_id], doctor_id: params[:doctor_id])
    @hospital = Hospital.find(params[:hospital_id])
    @doctor = @hospital.doctor
    redirect_to hospital_doctors_path, notice: 'Doctor has been added to Hospital'
  end

  def remove_doctor
    @hospital = Hospital.find(params[:hospital_id])
    @user = User.find(params[:doctor_id])
    HospitalTreatment.find_by(hospital_id: params[:hospital_id], doctor_id: params[:doctor_id]).destroy
    redirect_to hospital_doctors_path, notice: 'Doctor has been removed from Hospital.'
  end
end