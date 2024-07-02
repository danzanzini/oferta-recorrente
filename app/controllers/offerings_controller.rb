# frozen_string_literal: true

class OfferingsController < ApplicationController
  before_action :require_login
  before_action :set_offering, only: %i[show edit update destroy print]

  # GET /offerings or /offerings.json
  def index
    @offerings = Offering.all
  end

  # GET /offerings/1 or /offerings/1.json
  def show; end

  # GET /offerings/new
  def new
    @offering = Offering.new
    @offering.offered_products.build
    authorize @offering
  end

  # GET /offerings/1/edit
  def edit; end

  # POST /offerings or /offerings.json
  def create
    @offering = Offering.new(offering_params)
    @offering.organization = current_organization
    authorize @offering

    respond_to do |format|
      if @offering.save
        format.html { redirect_to offering_url(@offering), notice: 'Offering was successfully created.' }
        format.json { render :show, status: :created, location: @offering }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offerings/1 or /offerings/1.json
  def update
    respond_to do |format|
      if @offering.update(offering_params)
        format.html { redirect_to offering_url(@offering), notice: 'Offering was successfully updated.' }
        format.json { render :show, status: :ok, location: @offering }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offerings/1 or /offerings/1.json
  def destroy
    @offering.update_attribute!(:active, false)

    respond_to do |format|
      format.html { redirect_to offerings_url, notice: 'Offering was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print
    @harvests = @offering.harvests
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_offering
    @offering = Offering.find(params[:id])
    authorize @offering
  end

  # Only allow a list of trusted parameters through.
  def offering_params
    params.require(:offering).permit(
      :opens_at, :closes_at, :harvest_at, :location_id,
      offered_products_attributes: %i[id product_id amount _destroy]
    )
  end
end
