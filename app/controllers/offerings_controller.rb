# frozen_string_literal: true

class OfferingsController < ApplicationController
  before_action :require_login
  before_action :set_offering, only: %i[show edit update destroy print toggle_publish]

  # GET /offerings or /offerings.json
  def index
    @offerings = if current_user.producer? && current_user.managed_locations.any?
      Offering.where(location: current_user.managed_locations)
    else
      Offering.all
    end
    authorize @offerings
  end

  # GET /offerings/1 or /offerings/1.json
  def show; end

  # GET /offerings/new
  def new
    @offering = Offering.new
    if params[:from_id]
      source = Offering.find_by(id: params[:from_id])
      if source
        @offering.location_id = source.location_id
        source.offered_products.each do |op|
          @offering.offered_products.build(product_id: op.product_id, amount: op.amount)
        end
      else
        @offering.offered_products.build
      end
    else
      @offering.offered_products.build
    end
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

  def toggle_publish
    case @offering.publish_status
    when 'scheduled', 'closed'
      @offering.update!(publish_status: :open)
      notice = 'Oferenda publicada.'
    when 'open'
      @offering.update!(publish_status: :unpublished)
      notice = 'Oferenda despublicada.'
    when 'unpublished'
      @offering.update!(publish_status: :scheduled)
      notice = 'Oferenda agendada para publicação automática.'
    end
    redirect_to offering_url(@offering), notice: notice
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_offering
    @offering = Offering.find(params[:id])
    @offering.transition_status!
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
