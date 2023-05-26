class EquipmentController < ApplicationController
  before_action :authenticate_user!
  before_action :set_equipment, only: %i[ show edit update destroy ]

  # GET /equipment or /equipment.json
  def index
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      query = "name LIKE :search OR status = :status"
      bindings = { search: search_term, status: Equipment.statuses[params[:search]] }

      if params[:search] == "Peso libre"
        query += " OR free_weigth = :free_weigth"
        bindings[:free_weigth] = true
      end

      @equipments = Equipment.where(query, bindings)
    else
      @equipments = Equipment.all
    end
  end

  # GET /equipment/1 or /equipment/1.json
  def show
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
  end

  # GET /equipment/1/edit
  def edit
  end

  # POST /equipment or /equipment.json
  def create
    params = equipment_params
    params[:status]= params[:status].to_i
    @equipment = Equipment.new(params)

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to  equipment_index_path, notice: "Equipment was successfully created." }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment/1 or /equipment/1.json
  def update
    params = equipment_params
    params[:status]= params[:status].to_i
    if params[:current_password].present?
      if current_user.valid_password?(params[:current_password])
        params.delete(:current_password)
    respond_to do |format|
      if @equipment.update(params)
        format.html { redirect_to equipment_index_path, notice: "Equipment was successfully updated." }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
    else
      flash[:alert] = "Current password is incorrect"
      redirect_to equipment_index_path
    end
  else
    flash[:alert] = "Current password is required"
    redirect_to equipment_index_path
  end
end


  # DELETE /equipment/1 or /equipment/1.json
  def destroy
    @equipment.destroy

    respond_to do |format|
      format.html { redirect_to equipment_index_url, notice: "Equipment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
      @equipment = Equipment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def equipment_params
      params.require(:equipment).permit(:free_weigth, :name, :status, :current_password)
    end
end
