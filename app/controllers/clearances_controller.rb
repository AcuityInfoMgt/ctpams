class ClearancesController < ApplicationController
  before_action :set_clearance, only: [:show, :edit, :update, :destroy]

  # GET /clearances
  # GET /clearances.json
  def index
    @clearances = Clearance.all
  end

  # GET /clearances/1
  # GET /clearances/1.json
  def show
  end

  # GET /clearances/new
  def new
    @clearance = Clearance.new
  end

  # GET /clearances/1/edit
  def edit
  end

  # POST /clearances
  # POST /clearances.json
  def create
    @clearance = Clearance.new(clearance_params)

    respond_to do |format|
      if @clearance.save
        format.html { redirect_to @clearance, notice: 'Clearance was successfully created.' }
        format.json { render :show, status: :created, location: @clearance }
      else
        format.html { render :new }
        format.json { render json: @clearance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clearances/1
  # PATCH/PUT /clearances/1.json
  def update
    respond_to do |format|
      if @clearance.update(clearance_params)
        format.html { redirect_to @clearance, notice: 'Clearance was successfully updated.' }
        format.json { render :show, status: :ok, location: @clearance }
      else
        format.html { render :edit }
        format.json { render json: @clearance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clearances/1
  # DELETE /clearances/1.json
  def destroy
    @clearance.destroy
    respond_to do |format|
      format.html { redirect_to clearances_url, notice: 'Clearance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clearance
      @clearance = Clearance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clearance_params
      #params[:clearance]
      params.require(:clearance).permit(:name, :clearance_status, :comments)
    end
end
