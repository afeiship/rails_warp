# lib/rails_warp/jbuilder_extension.rb
module RailsWarp
  module JbuilderExtension
    def ok(**options)
      message = options[:message].nil? ? "success" : options[:message]
      code = options[:code] || 200

      set! :success, true
      set! :code, code
      set! :message, message

      yield if block_given?
    end

    def fail(**options)
      message = options[:message].nil? ? "error" : options[:message]
      code = options[:code] || 500

      set! :success, false
      set! :code, code
      set! :message, message

      yield if block_given?
    end

    # 别名方法
    alias_method :warp_ok, :ok
    alias_method :warp_fail, :fail
  end
end
