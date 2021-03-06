class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  respond_to :json, :html
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
	  @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    respond_with(@user)
  end
  
  def new
    @user = User.new
  end

  def edit
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "用户已经删除"
    redirect_to users_url
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "修改成功"
      redirect_to @user
    else
      render 'edit'
    end
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

  def following
    @title = "关注"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "粉丝"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
