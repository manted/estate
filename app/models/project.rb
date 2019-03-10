class Project < ApplicationRecord
    has_one :settlement

    PROPERTY_STATUS = [
        "Prepare Settlement",
        "Second status"
    ]

    def status
        return "Prepare Settlement" unless settlement 
        if settlement.final_settlement_date.present?
            "Settled"
        elsif settlement.title_registered_date.present? || settlement.planned_settlement_date.present?
            "Title Registered"
        else settlement.estimated_settlement_date.present?
            "Prepare Settlement"
        end
    end

    def date_string(date)
        return "" unless settlement
        settlement.date_string(date)
    end
end
