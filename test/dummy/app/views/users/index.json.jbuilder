# 使用 ok 方法
json.ok message: "Users retrieved successfully", code: 200
json.data do
  json.array! @users do |user|
    json.id user.id
    json.name user.name
    json.created_at user.created_at
  end
end
