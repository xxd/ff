class UsersController < ApplicationController
  def show
	@user = User.find(params[:id])
  end
  
  def new
  	@user = User.new
  end

  def create
  	#@user = User.new(params[:user]) #Rails之前版本使用，意思是@user = User.new(name: "Foo Bar", email: "foo@invalid", password: "foo", password_confirmation: "bar")
  	@user = User.new(user_params) #Rails4以后的新写法
  	if @user.save
       flash[:success] = "欢迎来到痣上。。。。"
  		 redirect_to @user
  	else
  		 render 'new'
  	end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
