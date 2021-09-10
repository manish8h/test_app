class SessionsController < ApplicationController

  def new

  end

  def create
    # session_params
    # binding.pry
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in Successfully"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Email or Password is wrong. Please try again"
      render 'new'
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out Successfully"
    redirect_to root_path
  end


  private

  def session_params
    params.require(:session).permit( :email, :password)
  end

end

