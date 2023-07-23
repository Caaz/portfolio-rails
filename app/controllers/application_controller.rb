class ApplicationController < ActionController::Base
    before_action :set_opengraph_values
    protected
    def set_opengraph_values
        @og = {
            title: "Daniel Cavazos",
            type: :website,
            image: helpers.asset_url("social.png"),
            url: request.original_url
        }
    end
end
