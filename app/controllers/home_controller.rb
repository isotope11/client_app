class HomeController < ApplicationController
  def index
    @client_applications = ClientApplication.all
  end
end
