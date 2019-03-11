class Project < ApplicationRecord
    has_one :settlement

    PROPERTY_STATUS = [
        "",
        "Prepare Settlement",
        "Title Registered",
        "Settled"
    ]

    PROJECT_FIELDS = {
        :property_status => {
            :type => "select",
            :options => PROPERTY_STATUS,
            :title => "Status"
        },
        :lot => {
            :type => "string",
            :title => "Lot"
        },
        :estate => {
            :type => "string",
            :title => "Estate"
        },
        :office => {
            :type => "string",
            :title => "Office"
        },
        :client_name => {
            :type => "string",
            :title => "Client Name"
        },
        :firb => {
            :type => "string",
            :options => [ "Y", "N" ],
            :title => "FIRB"
        },
        :solicitor => {
            :type => "string",
            :title => "Solicitor"
        },
        :builder => {
            :type => "string",
            :title => "Builder"
        }
    }

    SETTLEMENT_FIELDS = {
        :property_type => {
            :type => "string",
            :options => [ "Normal", "Titled" ],
            :title => "Property Type"
        },
        :estimated_settlement_date => {
            :type => "date",
            :title => "Est. Settle Date"
        },
        :title_registered_date => {
            :type => "date",
            :title => "Title Registered Date"
        },
        :planned_settlement_date => {
            :type => "date",
            :title => "Planned Settle Date"
        },
        :final_settlement_date => {
            :type => "date",
            :title => "Final Settle Date"
        },
        :funds_type => {
            :type => "select",
            :options => [ "Cash", "External Brokers", "JD Broker", "JD Loan" ],
            :title => "Funds Type"
        },
        :broker => {
            :type => "string",
            :title => "Broker"
        }
    }

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
