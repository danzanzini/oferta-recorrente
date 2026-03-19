# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: %i[show edit update destroy toggle_active]

  # GET /users or /users.json
  def index
    @users = policy_scope(User)
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
    authorize @user
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.organization = current_organization
    @user.password = user_params['email']
    authorize @user
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    authorize @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/edit_password
  def edit_password; end

  # PATCH /users/update_password
  def update_password
    if current_user.update(password_params)
      redirect_to root_path, notice: 'Senha alterada com sucesso.'
    else
      render :edit_password, status: :unprocessable_entity
    end
  end

  # POST /users/1/toggle_active
  def toggle_active
    authorize @user
    @user.toggle_active!
    notice = @user.active? ? 'Usuário ativado.' : 'Usuário desativado.'
    redirect_to user_url(@user), notice: notice
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    authorize @user
    @user.update_attribute!(:active, false)

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deactivated.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :role)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
