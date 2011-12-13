class ClientApplicationsController < ApplicationController

  def index
    @applications = ClientApplication.all
  end

  def show
    @application = ClientApplication.find(params[:id])
  end

  def new
    @application = ClientApplication.new
  end

  def create
    @application = ClientApplication.new(params[:client_application])
    if @application.save
      @application.submit!
      redirect_to edit_client_application_path(@application)
      flash[:notice] = "Application submitted successfully"
    else
      redirect_to :back
      flash[:error] = "Application Failed to submit! Please check any errors and try again."
    end
  end

  def edit
    @application = ClientApplication.find(params[:id])
    render @application.state
  end

  def update
    @application = ClientApplication.find(params[:id])
    if @application.state == "submitted"
      @application.requesting!
      message = "This application has been sent in for request"
    elsif @application.state == "requested"
      @application.respond!
      message = "This application has been sent in for response"
    elsif @application.state == "responded"
      @application.complete!
      message = "This application is complete"
    elsif @application.state == "completed"
      message = "This application is really complete"
    end
      redirect_to edit_client_application_path(@application)
      flash[:messasge] = message
  end

  def destroy
    @application = ClientApplication.find(params[:id])
    @application.destroy
  end
end
