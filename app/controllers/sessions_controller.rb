class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
