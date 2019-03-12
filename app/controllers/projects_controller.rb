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
    # settlement
    valid_settlement_params = {}
    settlement_search_params.each do |key, val|
      valid_settlement_params[("settlements."+key).to_sym] = val if val.present?
    end
    valid_params = valid_params.reverse_merge(valid_settlement_params)
    puts @projects
    @projects = Project.joins(:settlement).where(valid_params)
    # settlement date
    year_from = settlement_date_search_params[:estimated_year_from]
    month_from = settlement_date_search_params[:estimated_month_from]
    year_to = settlement_date_search_params[:estimated_year_to]
    month_to = settlement_date_search_params[:estimated_month_to]
    from_date = nil
    if year_from.present?
      search_year_from = year_from.to_i
      search_month_from = month_from.present? ? month_from.to_i : 1
      from_date = Date.new(search_year_from, search_month_from, 1)
    end
    to_date = nil
    if year_to.present?
      search_year_to = year_to.to_i
      search_month_to = month_to.present? ? month_to.to_i : 12
      to_date = Date.new(search_year_to, search_month_to, 1).end_of_month
    end
    if from_date && to_date
      @projects = @projects.where("settlements.estimated_settlement_date >= ? AND settlements.estimated_settlement_date <= ?", from_date, to_date)
    elsif from_date
      @projects = @projects.where("settlements.estimated_settlement_date >= ?", from_date)
    elsif to_date
      @projects = @projects.where("settlements.estimated_settlement_date <= ?", to_date)
    end
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
    params.require(:project).permit(:property_type, :funds_type, :estimated_settlement_date, :title_registered_date, :planned_settlement_date, :final_settlement_date, :funds_type, :broker)
  end

  def settlement_date_params
    params.require(:project).permit(:estimated_settlement_date, :title_registered_date, :planned_settlement_date, :final_settlement_date)
  end

  def search_params
    params.permit(:property_status, :lot, :estate, :address, :office, :client_name, :solicitor, :builder)
  end

  def settlement_search_params
    params.permit(:funds_type, :broker)
  end

  def settlement_date_search_params
    params.permit(:estimated_year_from, :estimated_month_from, :estimated_year_to, :estimated_month_to)
  end
end
