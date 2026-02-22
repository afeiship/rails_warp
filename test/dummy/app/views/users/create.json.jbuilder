# 根据实例变量 @success 来决定返回成功或失败响应
if @success
  json.ok code: 201
  json.data do
    json.id @user.id
    json.name @user.name
    json.created_at @user.created_at
  end
else
  json.fail message: "Validation failed", code: 422
  json.data do
    json.errors @user.errors.full_messages
  end
end
