class ProjectsController < ApplicationController
  include StringDate

  def index
    @projects = Project.includes(:settlement)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      create_or_update_settlement

      redirect_to @project
    else
      render 'edit'
    end
  end

  def create
    @project = Project.new(project_params)
    @project.save
    create_or_update_settlement
    redirect_to @project
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
   
    redirect_to projects_path
  end

  def search
    valid_params = {}
    search_params.each do |key, val|
      valid_params[key.to_sym] = val if val.present?
    end
    @projects = Project.where(valid_params)
  end

  private

  def create_or_update_settlement
    if @project.settlement
      @project.settlement.update(settlement_params)
    else
      @project.create_settlement(settlement_params)
    end

    estimated_settlement_date = date_from_string(settlement_params[:estimated_settlement_date])
    title_registered_date = date_from_string(settlement_params[:title_registered_date])
    planned_settlement_date = date_from_string(settlement_params[:planned_settlement_date])
    final_settlement_date = date_from_string(settlement_params[:final_settlement_date])
    if title_registered_date && !planned_settlement_date
      # add 20 days
      planned_settlement_date = title_registered_date + 20.days
    end
    @project.settlement.estimated_settlement_date = estimated_settlement_date
    @project.settlement.title_registered_date = title_registered_date
    @project.settlement.planned_settlement_date = planned_settlement_date
    @project.settlement.final_settlement_date = final_settlement_date
    @project.settlement.save

    @project.update_attributes(property_status: @project.status)
  end

  def project_params
    params.require(:project).permit(:lot, :estate, :address, :office, :client_name, :firb, :solicitor, :builder)
  end

  def settlement_params
    params.require(:project).permit(:estimated_settlement_date, :title_registered_date, :planned_settlement_date, :final_settlement_date, :funds_type, :broker)
  end

  def settlement_date_params
    params.require(:project).permit(:estimated_settlement_date, :title_registered_date, :planned_settlement_date, :final_settlement_date)
  end

  def search_params
    params.permit(:property_status, :lot, :estate, :address, :office, :client_name, :firb, :solicitor, :builder)
  end
end
