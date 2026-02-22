# 使用 warp_ok 方法 + single partial
json.warp_ok message: "User retrieved with partial", code: 200
json.data do
  json.partial! "users/user", user: @user
end
