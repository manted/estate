class CalendarController < ApplicationController
  def index
    Time.zone = "Melbourne"
    now = Time.zone.now
    estimated_dates = now ... now + 90.days
    @estimated_projects = Project.joins(:settlement).where("settlements.estimated_settlement_date" => estimated_dates).order("settlements.estimated_settlement_date")
    puts @estimated_projects

    planned_dates = now ... now + 30.days
    @planned_projects = Project.joins(:settlement).where("settlements.planned_settlement_date" => planned_dates).order("settlements.planned_settlement_date")
    puts @planned_projects

    final_dates = now ... now + 30.days
    @final_projects = Project.joins(:settlement).where("settlements.final_settlement_date" => final_dates).order("settlements.final_settlement_date")
    puts @final_projects

    # render 'index'
  end
end