# lib/rails_warp/response_wrapper.rb
module RailsWarp
  module ResponseWrapper
    extend ActiveSupport::Concern

    # 成功响应 - 仅支持 Hash 参数
    def ok(**options)
      data = options[:data]
      message = options[:message] || nil
      code = options[:code] || 200
      render json: build_response(true, data, message, code, **options.except(:data, :message, :code))
    end

    # 失败响应 - 仅支持 Hash 参数
    def fail(**options)
      message = options[:message] || "error"
      code = options[:code] || 500
      data = options[:data]
      render json: build_response(false, data, message, code, **options.except(:data, :message, :code)), status: get_http_status(code)
    end

    private

    # 构建响应体
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

    # 将 code 映射到 HTTP 状态码
    def get_http_status(code)
      case code
      when 200, 201, 204 then code
      when 400 then :bad_request
      when 401 then :unauthorized
      when 403 then :forbidden
      when 404 then :not_found
      when 422 then :unprocessable_entity
      when 500 then :internal_server_error
      else code
      end
    end
  end
end