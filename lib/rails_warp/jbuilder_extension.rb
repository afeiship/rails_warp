# lib/rails_warp/jbuilder_extension.rb
module RailsWarp
  module JbuilderExtension
    def ok(**options)
      set! :success, true
      set! :code, options[:code] || 200

      # message field always exists, defaults to null when not provided
      set! :message, options.key?(:message) ? options[:message] : nil

      yield if block_given?
    end

    def fail(**options)
      set! :success, false
      set! :code, options[:code] || 500

      # message field always exists, defaults to null when not provided
      set! :message, options.key?(:message) ? options[:message] : nil

      yield if block_given?
    end

    # Alias methods
    alias_method :warp_ok, :ok
    alias_method :warp_fail, :fail
  end
end
