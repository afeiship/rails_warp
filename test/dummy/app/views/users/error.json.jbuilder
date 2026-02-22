# 使用 fail 方法
json.fail message: "Validation failed", code: 422
json.data do
  json.field_errors do
    @user.errors.each do |attribute, messages|
      json.set! attribute do
        json.array! messages
      end
    end
  end
end
