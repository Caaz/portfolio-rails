class ApplicationController < ActionController::Base
    before_action :set_opengraph_values
    before_action :set_contact_request, only: :home
    protected
    def set_contact_request
        @contact_request = ContactRequest.new
    end
    def set_opengraph_values
        @og = {
            title: "Daniel Cavazos",
            type: :website,
            image: helpers.asset_url("social.png"),
            url: request.original_url,
            description: "Daniel Cavazos's Portfolio",
            locale:"en_US"
        }
    end
end
