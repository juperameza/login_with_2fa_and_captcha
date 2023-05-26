class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: %i[ show edit update destroy ]
  before_action :admin_only, only: %i[ destroy ]
  # GET /clients or /clients.json
  def index
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @clients = Client.where("name LIKE ?", search_term)
    else
      @clients = Client.all
    end
  end

  # GET /clients/1 or /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients or /clients.json
  def create
    params = client_params
    if params[:current_password].present?
      if current_user.valid_password?(params[:current_password])
        params.delete(:current_password)
        @client = Client.new(params)
        respond_to do |format|
          if @client.save
            format.html { redirect_to clients_path, notice: "Client was successfully created." }
            format.json { render :show, status: :created, location: @client }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @client.errors, status: :unprocessable_entity }
          end
        end
      else
        flash[:alert] = "Current password is incorrect"
        redirect_to :back
      end
    else
      flash[:alert] = "Current password is required"
      redirect_to :back
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    params = client_params
    if params[:current_password].present?
      if current_user.valid_password?(params[:current_password])
        params.delete(:current_password)
      respond_to do |format|
        if @client.update(params)
          format.html { redirect_to clients_path, notice: "Client was successfully updated." }
          format.json { render :show, status: :ok, location: @client }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @client.errors, status: :unprocessable_entity }
        end
      end
      else
        flash[:alert] = "Current password is incorrect"
        render :edit
      end
    else
      flash[:alert] = "Current password is required"
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, notice: "Client was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:name, :birthdate, :membership, :emergency_cname, :emergency_cphone, :current_password)
    end
end
