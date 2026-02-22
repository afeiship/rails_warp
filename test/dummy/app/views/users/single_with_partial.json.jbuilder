# 使用 ok 方法 + single partial
json.ok message: "User retrieved with partial", code: 200
json.data do
  json.partial! "users/user", user: @user
end
