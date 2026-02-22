# 使用 warp_fail 方法
json.warp_fail message: "Validation failed", code: 422
json.data do
  json.field_errors do
    @user.errors.each do |attribute, messages|
      json.set! attribute do
        json.array! messages
      end
    end
  end
end
