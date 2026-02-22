# lib/rails_warp/jbuilder_extension.rb
module RailsWarp
  module JbuilderExtension
    # 忽略方法_missing 中的特定方法名
    # 我们需要覆盖 method_missing 来拦截这些调用
    def method_missing(method_name, *args, &block)
      if method_name == :warp_ok || method_name == :ok
        _warp_ok(*args, &block)
      elsif method_name == :warp_fail || method_name == :fail
        _warp_fail(*args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name == :warp_ok || method_name == :ok ||
      method_name == :warp_fail || method_name == :fail || super
    end

    private

    def _warp_ok(**options)
      message = options[:message] || "success"
      code = options[:code] || 200

      set! :success, true
      set! :code, code
      set! :message, message

      yield if block_given?
    end

    def _warp_fail(**options)
      message = options[:message] || "error"
      code = options[:code] || 500

      set! :success, false
      set! :code, code
      set! :message, message

      yield if block_given?
    end
  end
end
