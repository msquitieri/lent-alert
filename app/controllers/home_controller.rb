class HomeController < ApplicationController
  def index
    @time_zones = ActiveSupport::TimeZone.us_zones
  end
end
