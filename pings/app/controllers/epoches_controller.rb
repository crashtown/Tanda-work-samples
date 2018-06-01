class EpochesController < ApplicationController
  before_action :set_epoch, only: [:show, :edit, :update, :destroy]

  # GET /epoches
  # GET /epoches.json
  def index
    @epoches = Epoch.all
  end

  # GET /epoches/1
  # GET /epoches/1.json
  def show
  end

  # GET /epoches/new
  def new
    @epoch = Epoch.new
  end

  # GET /epoches/1/edit
  def edit
  end

  # POST /epoches
  # POST /epoches.json
  def create
    @epoch = Epoch.new(epoch_params)

    respond_to do |format|
      if @epoch.save
        format.html { redirect_to @epoch, notice: 'Epoch was successfully created.' }
        format.json { render :show, status: :created, location: @epoch }
      else
        format.html { render :new }
        format.json { render json: @epoch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /epoches/1
  # PATCH/PUT /epoches/1.json
  def update
    respond_to do |format|
      if @epoch.update(epoch_params)
        format.html { redirect_to @epoch, notice: 'Epoch was successfully updated.' }
        format.json { render :show, status: :ok, location: @epoch }
      else
        format.html { render :edit }
        format.json { render json: @epoch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /epoches/1
  # DELETE /epoches/1.json
  def destroy
    @epoch.destroy
    respond_to do |format|
      format.html { redirect_to epoches_url, notice: 'Epoch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_epoch
      @epoch = Epoch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def epoch_params
      params.require(:epoch).permit(:time, :device_id)
    end
end
