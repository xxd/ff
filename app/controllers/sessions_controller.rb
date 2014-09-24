class SessionsController < ApplicationController
  def new
  end

  def create
#    user = User.find_by(email: params[:session][:email].downcase) || User.find_by(name: params[:session][:name].downcase) #尝试username和email登陆不行
	  user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Email或者密码错误' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
