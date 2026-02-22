# 使用 ok 方法 + partial 模板
json.ok message: "Users retrieved with partials", code: 200
json.data do
  json.array! @users, partial: "users/user", as: :user
end
