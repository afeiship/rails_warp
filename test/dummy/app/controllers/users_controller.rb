# app/controllers/api/v1/users_controller.rb (或其他 Controller)
class UsersController < ApplicationController
  # 由于插件在初始化时自动包含了 ResponseWrapper 模块，
  # 你现在可以直接在任何继承自 ApplicationController 的控制器中使用 ok/fail 方法

  def index
    users = User.limit(10)
    ok(data: users, message: "Users retrieved successfully", code: 200)
  end

  def show
    user = User.find(params[:id])
    ok(data: user)
  rescue ActiveRecord::RecordNotFound
    fail(message: "User not found", code: 404)
  end

  def create
    user = User.new(user_params)
    if user.save
      ok(data: user, message: "User created successfully", code: 201)
    else
      fail(message: "Validation failed", code: 422, errors: user.errors)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end