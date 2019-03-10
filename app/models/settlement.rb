class Settlement < ApplicationRecord
  include StringDate
  belongs_to :project
  # after_save :update_project_status

  DATES = [
    "Estimated Settlement Date",
    "Title Registered Date",
    "Planned Settlement Date",
    "Final Settlement Date"
  ]

  # def update_project_status
  #   project.update_attributes(property_status: project.status)
  # end

  def date_string(date)
    string_from_date(self[date])
  end
end
