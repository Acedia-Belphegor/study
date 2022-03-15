class PatientsController < ApplicationController

  def index
    patients = Patient.all.order(:created_at)
    render json: {
      data: patients.map { |patient| PatientSerializer.new(patient) }
    }
  end

  def show
  end

end
