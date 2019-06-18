class ClientsController < ApplicationController
  include Secured
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  def index
    @clients = Client.all
    @user = session[:userinfo]
    @clinician_id = @user['uid']
    @clinician_id.to_s
    @clinician_id = @clinician_id[6..30]
    clinicican = params[:clinicican]
    @clients = @clients.where("clinician_id = '#{@clinician_id}'", clinicican)
  end

  # GET /clients/1
  def show
    @clients = Client.find(params[:id])
    @user = session[:userinfo]
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params.permit(:first_name, :last_name, :sex, :birth_date, :postcode, :marital_status, :sexuality, :ethnicity, :indigenous, :children, :workforce_status))
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
      @user = session[:userinfo]
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
      params.fetch(:client, {})
    end
end
