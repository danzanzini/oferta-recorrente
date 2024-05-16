# frozen_string_literal: true

class HarvestsController < ApplicationController
  before_action :require_login
  before_action :set_harvest, only: %i[show edit update]

  # GET /harvests or /harvests.json
  def index
    @harvests = Harvest.all
  end

  # GET /harvests/1 or /harvests/1.json
  def show; end

  # GET /harvests/new
  def new
    @harvest = Harvest.new(
      user: current_user,
      offering: current_user.current_offering
    )
  end

  # GET /harvests/1/edit
  def edit; end

  # POST /harvests or /harvests.json
  def create
    @harvest = Harvest.new(harvest_params)
    @harvest.user = current_user

    respond_to do |format|
      if @harvest.save
        format.html { redirect_to harvest_url(@harvest), notice: 'Harvest was successfully created.' }
        format.json { render :show, status: :created, location: @harvest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @harvest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /harvests/1 or /harvests/1.json
  def update
    respond_to do |format|
      if @harvest.update(harvest_params)
        format.html { redirect_to harvest_url(@harvest), notice: 'Harvest was successfully updated.' }
        format.json { render :show, status: :ok, location: @harvest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @harvest.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_harvest
    @harvest = Harvest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def harvest_params
    params.require(:harvest).permit(:none)
  end
end
