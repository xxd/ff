class SessionsController < ApplicationController
  # respond_to :html, :json
  def new
  end

  def create
#    user = User.find_by(email: params[:session][:email].downcase) || User.find_by(name: params[:session][:name].downcase) #尝试username和email登陆不行
	  user = User.find_by(email: params[:session][:email].downcase)
    @user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      # redirect_to user #只返回html
      respond_to do |format|
        format.html { redirect_to @user } 
        # format.json { render json: @user } #返回全部@user
        format.json { render json: @user.as_json(  only: [ :id, :name, :email ] ) }
      end  
      # respond_with(@user) #也可以，但是是返回全部
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
