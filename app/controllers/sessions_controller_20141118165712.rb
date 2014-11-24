class SessionsController < ApplicationController
  respond_to :html, :json

  def new
  end

  def create
#    user = User.find_by(email: params[:session][:email].downcase) || User.find_by(name: params[:session][:name].downcase) #尝试username和email登陆不行
	  user = User.find_by(email: params[:session][:email].downcase)
    puts params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      sign_in user
      #format.html { redirect_to user }
      format.json @user
    else
      flash.now[:error] = 'Email或者密码错误' # Not quite right!
      #render 'new'
      render json: 0
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
