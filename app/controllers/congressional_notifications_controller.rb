class CongressionalNotificationsController < ApplicationController
  before_action :set_congressional_notification, only: [:show, :edit, :update, :destroy]

  # GET /congressional_notifications
  # GET /congressional_notifications.json
  def index
    @congressional_notifications = CongressionalNotification.filter(params)
  end

  # GET /congressional_notifications/1
  # GET /congressional_notifications/1.json
  def show
    @states = CongressionalNotification.workflow_spec.states.keys
    @states.shift
    @states.pop
  end

  # GET /congressional_notifications/new
  def new
    @congressional_notification = CongressionalNotification.new
  end

  # GET /congressional_notifications/1/edit
  def edit
  end

  # POST /congressional_notifications
  # POST /congressional_notifications.json
  def create
    @congressional_notification = CongressionalNotification.new(congressional_notification_params)

    respond_to do |format|
      if @congressional_notification.save
        format.html { redirect_to @congressional_notification, notice: 'Congressional notification was successfully created.' }
        format.json { render :show, status: :created, location: @congressional_notification }
      else
        format.html { render :new }
        format.json { render json: @congressional_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /congressional_notifications/1
  # PATCH/PUT /congressional_notifications/1.json
  def update
    respond_to do |format|
      if @congressional_notification.update(congressional_notification_params)
        format.html { redirect_to @congressional_notification, notice: 'Congressional notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @congressional_notification }
      else
        format.html { render :edit }
        format.json { render json: @congressional_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /congressional_notifications/1
  # DELETE /congressional_notifications/1.json
  def destroy
    @congressional_notification.destroy
    respond_to do |format|
      format.html { redirect_to congressional_notifications_url, notice: 'Congressional notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_congressional_notification
      @congressional_notification = CongressionalNotification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def congressional_notification_params
      params.require(:congressional_notification).permit(:name, :cn_number, project_ids: [])
    end
end
