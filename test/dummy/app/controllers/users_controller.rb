# app/controllers/api/v1/users_controller.rb (或其他 Controller)
class UsersController < ApplicationController
  # 由于插件在初始化时自动包含了 ResponseWrapper 模块，
  # 你现在可以直接在任何继承自 ApplicationController 的控制器中使用 ok/fail 方法

  skip_before_action :verify_authenticity_token

  def index
    @users = User.limit(10)
  end

  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # 返回 jbuilder 错误响应
    render json: { success: false, code: 404, message: "User not found", data: nil }
  end

  def create
    @user = User.new(user_params)
    @success = @user.save
  end

  def error
    @user = User.new
    @user.errors.add(:name, "can't be blank")
    @user.errors.add(:email, "is invalid")
  end

  def with_partial
    @users = User.limit(5)
  end

  def single_with_partial
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end