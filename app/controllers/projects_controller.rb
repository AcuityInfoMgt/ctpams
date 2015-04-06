class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :start_date, :end_date, :budget_requested, :fiscal_year, :objective, :interest, :law_enforcement, :coordination, :lessons_learned, :sustainability, :city_province, :program_audience, :reprogram, :reprogram_comments, :implementation_status, :program, :user_id, :is_archived, :is_denied, :is_active, people_attributes: [:id, :name, :email, :phone, :office, :_destroy], budget_items_attributes: [:id, :name, :budget_amount, :budgetable_id, :budgetable_type, :_destroy], obligations_attributes: [:id, :obligation_number, :obligation_amount, :obligation_date, :fiscal_year, :obligation_comments, :_destroy], attached_files_attributes: [:id, :name, :is_active, :attachable_id, :attachable_type, :attachable_document_file_name, :attachable_document_content_type, :attachable_document_file_size, :attachable_document, :_destroy], country_ids: [], sub_account_ids: [])
    end
end
