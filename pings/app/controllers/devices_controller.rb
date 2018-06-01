class DevicesController < ApplicationController
  # before_action :set_device, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /devices
  # GET /devices.json
  def clear_data
    Epoch.delete_all
    Device.delete_all
    head:ok
  end

  def create_device
    if  @device = Device.find_by_device_id(params[:device_id])
    else
      @device = Device.new(device_id_params)
      @device.save
    end
    @epoch = Epoch.new(epoch_params)
    @epoch.device_id = @device.id
    # date_format ="%Y-%m-%d"
    # DateTime.strptime(@epoch.date, date_format)
    @epoch.date = @epoch.date.to_i
    # render json: "matching format".to_json
    # rescue ArgumentError
    # false
    # render json: "doesnt match format".to_json
    @epoch.save
  end

  def get_device
    @device = Device.where(device_id: params[:device_id])
    @unix = params[:date]
    if @unix
      if @unix.include? "-"
        @unix = @unix.to_time.to_i
      else
      end
    else
    end
    @epoch = Epoch.find_by_date(@unix)
    @response = {}
    @device.each do | device |
      device.epoches.each do | epoch |
        epochunix = DateTime.strptime(epoch.date,'%s')
        if @response[device.device_id]
          @response[device.device_id].push(epochunix)
        else
          @response[device.device_id]= [epochunix]
        end
      end
    end
    render json: @response.to_json
  end

  def get_all
    @device = Device.all
    @epoch = Epoch.all
    @response = {}
    @device.each do | device |
      device.epoches.each do | epoch |
        if @response[device.device_id]
          @response[device.device_id].push(epoch.date)
        else
          @response[device.device_id]= [epoch.date]
        end
      end
    end
    render json: @response.to_json
  end

  def get_device_only
    @device = Device.all
    @response = []
    @device.each do | device |
      @response.push(device.device_id)
    end
    render json: @response.to_json
  end

  def index
    @devices = Device.all
  end

  def get_device_from_to
    @device = Device.where(device_id: params[:device_id])
    @from = params[:from]
    @to = params[:to]
    if @to.include? "-"
      @to_unix = @to.to_time.to_i
      else
        @to_unix = @to
    end
    if @from.include? "-"
      @from_unix = @from.to_time.to_i
      else
        @from_unix = @from
    end
    @to_unix = @to_unix.to_i
    @from_unix = @from_unix.to_i
    @response = []
    @device[0].epoches.each do | epoch |
      if epoch.date >= @from_unix && epoch.date < @to_unix
          @response.push(epoch.date)
      end
    end
      render json: @response.to_json
  end


  # # GET /devices/1
  # # GET /devices/1.json
  # def show
  # end
  #
  # # GET /devices/new
  # def new
  #   @device = Device.new
  # end
  #
  # # GET /devices/1/edit
  # def edit
  # end
  #
  # # POST /devices
  # # POST /devices.json
  # def create
  #   @device = Device.new(device_params)
  #
  #   respond_to do |format|
  #     if @device.save
  #       format.html { redirect_to @device, notice: 'Device was successfully created.' }
  #       format.json { render :show, status: :created, location: @device }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @device.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /devices/1
  # # PATCH/PUT /devices/1.json
  # def update
  #   respond_to do |format|
  #     if @device.update(device_params)
  #       format.html { redirect_to @device, notice: 'Device was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @device }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @device.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /devices/1
  # # DELETE /devices/1.json
  # def destroy
  #   @device.destroy
  #   respond_to do |format|
  #     format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # # Use callbacks to share common setup or constraints between actions.
    # def set_device
    #   @device = Device.find(params[:id])
    # end
    #
    # # Never trust parameters from the scary internet, only allow the white list through.
    def device_id_params
      params.permit(:device_id)
    end

    def epoch_params
      params.permit(:date)
    end
end
