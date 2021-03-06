module FbGraph
  class AdAccount < Node
    include Connections::AdCampaigns
    include Connections::AdSets
    include Connections::AdGroups
    include Connections::AdSetStats
    include Connections::AdGroupStats
    include Connections::BroadTargetingCategories
    include Connections::ReachEstimates
    include Connections::AdConnectionObjects
    include Connections::AdPreviews
    include Connections::AdImages
    include Connections::AdCreatives

    ATTRS = [
      :account_id,
      :name,
      :account_status,
      :daily_spend_limit,
      :users,
      :currency,
      :timezone_id,
      :timezone_name,
      :capabilities,
      :account_groups,
      :is_personal,
      :business_name,
      :business_street,
      :business_street2,
      :business_city,
      :business_state,
      :business_zip,
      :business_country_code,
      :vat_status,
      :agency_client_declaration,
      :spend_cap,
      :amount_spent
    ]

    attr_accessor *ATTRS

    def initialize(identifier, attributes = {})
      super

      ATTRS.each do |field|
        send("#{field}=", attributes[field.to_sym])
      end

      if attributes[:users]
        self.users = attributes[:users].collect { |u| FbGraph::AdUser.new(u["uid"], u) }
      end
    end

    def ad_credit_line!(options = {})
      ad_credit_line = post options.merge(:connection => :adcreditline)
    end

  end
end
