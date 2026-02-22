# lib/rails_warp/jbuilder_extension.rb
module RailsWarp
  module JbuilderExtension
    # 成功响应结构，用于 jbuilder 模板
    def warp_ok(**options)
      data = options[:data]
      message = options[:message] || "success"
      code = options[:code] || 200

      # 如果提供了块，将其用于构建 data
      if block_given?
        set! :success, true
        set! :code, code
        set! :message, message
        # 使用 set! 和一个临时对象来捕获 block 的内容
        data_hash = _capture_block do
          yield
        end
        set! :data, data_hash
      else
        # 构建响应哈希
        response_hash = build_response(true, data, message, code, **options.except(:data, :message, :code))
        # 将响应哈希的内容合并到当前 jbuilder 对象
        merge!(response_hash)
      end
    end

    # 失败响应结构，用于 jbuilder 模板
    def warp_fail(**options)
      message = options[:message] || "error"
      code = options[:code] || 500
      data = options[:data]

      # 如果提供了块，将其用于构建 data
      if block_given?
        set! :success, false
        set! :code, code
        set! :message, message
        # 使用 set! 和一个临时对象来捕获 block 的内容
        data_hash = _capture_block do
          yield
        end
        set! :data, data_hash
      else
        # 构建响应哈希
        response_hash = build_response(false, data, message, code, **options.except(:data, :message, :code))
        # 将响应哈希的内容合并到当前 jbuilder 对象
        merge!(response_hash)
      end
    end

    # 为 jbuilder 提供别名方法
    alias_method :ok, :warp_ok
    alias_method :fail, :warp_fail

    private

    # 捕获 block 的内容并返回哈希
    def _capture_block
      # 创建一个新的 Jbuilder 实例来捕获 block 内容
      temp = JbuilderTemplate.new(@context)
      yield(temp) if block_given?
      # 获取生成的哈希
      JSON.parse(temp.target!)
    end

    # 内部构建响应体的辅助方法
    def build_response(success, data, message, code, **extra)
      response_hash = {
        success: success,
        code: code,
        message: message,
        data: data
      }
      # 合并额外的字段
      response_hash.merge!(extra) if extra.present?
      response_hash
    end
  end
end
