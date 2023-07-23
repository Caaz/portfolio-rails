class ApplicationController < ActionController::Base
    before_action :set_opengraph_values
    protected
    def set_opengraph_values
        @og = {
            title: "Portfolio",
            type: :website,
            image: helpers.asset_url("social.svg"),
            url: request.original_url
        }
    end
end
