# 使用 json.warp_ok 方法
json.warp_ok message: "User found", code: 200
json.data do
  json.id @user.id
  json.name @user.name
  json.created_at @user.created_at
end
