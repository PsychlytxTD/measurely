class ScaleController < ApplicationController
include Secured
  before_action :set_scale, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :show]

  # GET /scales
  def index
    @scales = Scale.clinician_id_equals(@clinician_id).includes(:client)
    # @scales = @scales.where(client_id: scale_params[:client_id]) if scale_params[:client_id].present?
    @user = session[:userinfo]
  end

  # GET /scales/1
  def show
    @scales = Scale.find(params[:id])
    @user = session[:userinfo]
  end

  # GET /scales/new
  def new
    @scale = Scale.new
  end

  # GET /scales/1/edit
  def edit
    @scale = Scale.find(params[:id])
  end

  # POST /scales
  def create
    @scale = Scale.new(scale_params)

    if @scale.save
      redirect_to @scale, notice: 'Scale was successfully created.'
    else
      render :new
    end
  end

# PATCH/PUT /scales/1
  def update
    if @scale.update(scale_params.permit(:date, :score))
      redirect_to scale_index_path, notice: 'Scale was successfully updated.'
    else
      render :edit
    end
      # redirect_to(action: :index) #, notice: 'Scale was successfully updated.'
      # redirect_to scale_index_path
  end

  # DELETE /scales/1
  def destroy
    @scale.destroy
    redirect_to scale_index_path, notice: 'Scale was successfully destroyed.'
  end

  def add_clients
  	@clients = Client.all
  	@clinician_id = @user['uid']
    @clinician_id.to_s
    @clinician_id = @clinician_id[6..30]
    clinicican = params[:clinicican]
  	@clients = @clients.where("clinician_id = '#{@clinician_id}'", clinicican)
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_scale
      @scale = Scale.find(params[:id])
      @user = session[:userinfo]
    end

    # Only allow a trusted parameter "white list" through.
    def scale_params
      params.require(:scale).permit(client_id: [])
      # params.permit(:client_id)
    end
end
