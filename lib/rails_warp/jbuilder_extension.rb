# lib/rails_warp/jbuilder_extension.rb
module RailsWarp
  module JbuilderExtension
    # 成功响应结构，用于 jbuilder 模板
    def warp_ok(**options)
      data = options[:data]
      message = options[:message] || "success"
      code = options[:code] || 200
      # 构建响应哈希
      response_hash = build_response(true, data, message, code, **options.except(:data, :message, :code))
      # 将响应哈希的内容合并到当前 jbuilder 对象
      merge!(response_hash)
    end

    # 失败响应结构，用于 jbuilder 模板
    def warp_fail(**options)
      message = options[:message] || "error"
      code = options[:code] || 500
      data = options[:data]
      # 构建响应哈希
      response_hash = build_response(false, data, message, code, **options.except(:data, :message, :code))
      # 将响应哈希的内容合并到当前 jbuilder 对象
      merge!(response_hash)
    end

    # 为 jbuilder 提供别名方法
    alias_method :ok, :warp_ok
    alias_method :fail, :warp_fail

    private

    # 内部构建响应体的辅助方法
    def build_response(success, data, message, code, **extra)
      response_hash = {
        success: success,
        code: code,
        message: message,
        data: data # <--- 修改这里：明确写成 data: data
      }
      # 合并额外的字段
      response_hash.merge!(extra) if extra.present?
      response_hash
    end
  end
end

# Rails 应用启动时，将 JbuilderExtension 混入到 Jbuilder 的上下文
# Rails.application.config.after_initialize do
#   # Jbuilder 的上下文类通常是 Jbuilder 或 JbuilderTemplate
#   # 尝试混入到 Jbuilder 类
#   if defined?(Jbuilder)
#     Jbuilder.include RailsWarp::JbuilderExtension
#   end
#   # 如果 JbuilderTemplate 存在，也混入它 (在某些 Jbuilder 版本中可能需要)
#   if defined?(JbuilderTemplate)
#     JbuilderTemplate.include RailsWarp::JbuilderExtension
#   end
# end