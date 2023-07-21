require "net/http"

class ContactRequestsController < ApplicationController
  before_action :set_contact_request, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ index sshow edit update destroy ]
  after_action :send_webhook, only: :create
  # GET /contact_requests
  def index
    @contact_requests = ContactRequest.all.reverse
  end

  # GET /contact_requests/1
  def show
  end

  # GET /contact_requests/new
  def new
    @contact_request = ContactRequest.new
  end

  # GET /contact_requests/1/edit
  def edit
  end

  # POST /contact_requests
  def create
    @contact_request = ContactRequest.new(contact_request_params)

    if @contact_request.save
      redirect_to new_contact_request_url, notice: "Contact request sent!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contact_requests/1
  def update
    if @contact_request.update(contact_request_params)
      redirect_to @contact_request, notice: "Contact request was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /contact_requests/1
  def destroy
    @contact_request.destroy
    redirect_to contact_requests_url, notice: "Contact request was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_request
      @contact_request = ContactRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_request_params
      params.require(:contact_request).permit(:name, :message, :email, :phone)
    end

    def send_webhook
      if !ENV["DISCORD_WEBHOOK"]
        return
      end
      Net::HTTP.post(
        URI(ENV["DISCORD_WEBHOOK"]),
        { content: "New Contact request from #{@contact_request.name}" }.to_json,
        'Content-Type' => 'application/json'
      )
    end
end
