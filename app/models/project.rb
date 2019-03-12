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
        :address => {
            :type => "string",
            :title => "Address"
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
            :type => "select",
            :options => [ "Y", "N" ],
            :title => "FIRB",
            :ignore_search => true
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
            :type => "select",
            :options => [ "Normal", "Titled" ],
            :title => "Property Type",
            :ignore_search => true
        },
        :estimated_settlement_date => {
            :type => "date",
            :title => "Est. Settle Date",
            :search_options => [
              :estimated_year_from,
              :estimated_month_from,
              :estimated_year_to,
              :estimated_month_to
            ]
        },
        :title_registered_date => {
            :type => "date",
            :title => "Title Registered Date",
            :ignore_search => true
        },
        :planned_settlement_date => {
            :type => "date",
            :title => "Planned Settle Date",
            :ignore_search => true
        },
        :final_settlement_date => {
            :type => "date",
            :title => "Final Settle Date",
            :ignore_search => true
        },
        :funds_type => {
            :type => "select",
            :options => [ "", "Cash", "External Brokers", "JD Broker", "JD Loan" ],
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
