# lib/rails_warp/jbuilder_extension.rb
module RailsWarp
  module JbuilderExtension
    def ok(**options)
      set! :success, true
      set! :code, options[:code] || 200

      # message 字段始终存在，未传递时为 null
      set! :message, options.key?(:message) ? options[:message] : nil

      yield if block_given?
    end

    def fail(**options)
      set! :success, false
      set! :code, options[:code] || 500

      # message 字段始终存在，未传递时为 null
      set! :message, options.key?(:message) ? options[:message] : nil

      yield if block_given?
    end

    # 别名方法
    alias_method :warp_ok, :ok
    alias_method :warp_fail, :fail
  end
end
