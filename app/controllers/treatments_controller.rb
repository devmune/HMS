class TreatmentsController < ApplicationController
  def index
    @treatments = Treatment.all
    @hospital = Hospital.find(params[:hospital_id])
  end

  def show
    @treatment = Treatment.find(params[:id])
  end

  def edit
    @treatment = Treatment.find(params[:id])
  end

  def new
    @hospital = Hospital.find(params[:hospital_id])
    @treatment = Treatment.new
  end

  def destroy
    @treatment = Treatment.find(params[:id])
    @treatment.destroy

    respond_to do |format|
      format.html { redirect_to hospital_treatment_path, notice: 'Record was removed.' }
    end
  end

  def create
    @hospital = Hospital.find(params[:hospital_id])
    @treatment = Treatment.new(treatment_params)

    respond_to do |format|
      if @treatment.save
        format.html { redirect_to hospital_treatments_path(@hospital), notice: 'Treatment successfully added.' }
      else
        format.html { render new_treatment_path, status: :unprocessable_entity, content_type: "text/html" }
      end
    end
  end

  def update
    @treatment = Treatment.find(params[:id])
    @treatment.update(treatment_params)
    respond_to do |format|
      if @treatment.update(treatment_params)
        format.html { redirect_to hospital_treatment_path, notice: 'Your Treatment has been now updated.' }
      else
        format.html { render new_treatment_path, status: :unprocessable_entity, content_type: "text/html" }
      end
    end
  end

  private

  def treatment_params
    params.require(:treatment).permit(:name)
  end
end
