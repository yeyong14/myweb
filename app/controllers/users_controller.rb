#encsding:utf-8
class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update,
                                        :destroy, :following, :followers] 
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page]) 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "开始你的另一个推特!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "个人资料已更新"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
   # User.find(params[:id]).destroy
    flash[:success] = "#{params[:id]} 号被你干掉了"
    User.find(params[:id]).destroy
    redirect_to users_path
  end


  def following
    @title = "正在关注"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "关注者"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private


  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
