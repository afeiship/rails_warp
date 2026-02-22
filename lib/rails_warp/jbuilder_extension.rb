# lib/rails_warp/jbuilder_extension.rb
module RailsWarp
  module JbuilderExtension
    def ok(**options)
      set! :success, true
      set! :code, options[:code] || 200

      set! :message, options[:message] if options.key?(:message)

      yield if block_given?
    end

    def fail(**options)
      set! :success, false
      set! :code, options[:code] || 500

      set! :message, options[:message] if options.key?(:message)

      yield if block_given?
    end

    # 别名方法
    alias_method :warp_ok, :ok
    alias_method :warp_fail, :fail
  end
end
