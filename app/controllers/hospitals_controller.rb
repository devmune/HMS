class HospitalsController < ApplicationController
  def index
    @hospitals = Hospital.all
  end

  def new
    @hospital = Hospital.new
  end

  def show
    @hospital = Hospital.find(params[:id])
    @doctor_added = @hospital.doctor
    @hospital_treatments = @hospital.hospital_treatments.where.not(treatment_id: nil)
  end

  def destroy
    @hospital = Hospital.find(params[:id])
    @hospital.destroy

    respond_to do |format|
      format.html { redirect_to hospital_path, notice: 'Successfully deleted Hospital.' }
    end
  end

  def create
    @hospital = Hospital.create(hospital_params)
    respond_to do |format|
      if @hospital.save
        format.html { redirect_to hospitals_path, notice: 'Hospital successfully created.' }
      else
        format.html { render new_hospital_path, status: :unprocessable_entity, content_type: "text/html" }
      end
    end
  end

  def update
    @hospital = Hospital.find(params[:id])
    respond_to do |format|
      if @hospital.update(params.require(:hospital).permit(:name, :city, :address))
        format.html { redirect_to hospitals_path, notice: 'Hospital successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def edit
    @hospital = Hospital.find(params[:id])
    @doctors = User.Doctor.where.not(id: @hospital.doctor_ids)
  end
  private

  def hospital_params
    params.require(:hospital).permit(:name, :city, :address)
  end
end
