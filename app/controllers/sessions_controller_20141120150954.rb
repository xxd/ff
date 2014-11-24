class SessionsController < ApplicationController
  respond_to :json, :html
  def new
  end

  def create
#    user = User.find_by(email: params[:session][:email].downcase) || User.find_by(name: params[:session][:name].downcase) #尝试username和email登陆不行
	  user = User.find_by(email: params[:session][:email].downcase)
    @userInfo = User.find_by(email: params[:session][:email].downcase)
    puts @userInfo[:email]

    if user && user.authenticate(params[:session][:password])
      sign_in user
      #format.html { redirect_to user }
      # respond_to do |format|
      #   format.html { redirect_to user }
      #   # format.json { render json: @user.as_json(only: [:id], [:remember_token])}
      #   format.json { render json: @userInfo.as_json(  only: [ :id, :name, :email ] ) }
      # end
      render :json => @user[:remember_token]
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
