# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :require_login
  before_action :set_user

  def new
    @subscription = Subscription.new
    authorize @subscription
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user = @user
    @subscription.organization = current_organization
    authorize @subscription

    if @subscription.save
      redirect_to user_path(@user), notice: 'Assinatura criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @subscription = @user.subscription
    authorize @subscription
  end

  def update
    @subscription = @user.subscription
    authorize @subscription

    if @subscription.update(subscription_params)
      redirect_to user_path(@user), notice: 'Assinatura atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def subscription_params
    params.require(:subscription).permit(:item_limit, :location_id, :active)
  end
end
