# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new; end

  def create
    ActsAsTenant.without_tenant do
      user = User.find_by(email: params[:email])
      if user
        user.generate_password_reset_token!
        UserMailer.password_reset(user).deliver_now
      end
    end
    redirect_to new_session_url,
                notice: 'Se esse e-mail estiver cadastrado, você receberá uma instrução em breve.'
  end

  def edit
    @user = find_user_by_token
    redirect_to new_password_resets_url, alert: 'Link inválido ou expirado.' unless @user
  end

  def update
    @user = find_user_by_token
    unless @user
      redirect_to new_password_resets_url, alert: 'Link inválido ou expirado.' and return
    end

    if @user.update(password_params)
      @user.update_columns(password_reset_token: nil, password_reset_sent_at: nil)
      redirect_to new_session_url, notice: 'Senha redefinida com sucesso. Faça login.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def find_user_by_token
    ActsAsTenant.without_tenant do
      user = User.find_by(password_reset_token: params[:token])
      return nil if user.nil? || user.password_reset_expired?

      user
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
