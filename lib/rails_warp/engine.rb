# lib/rails_warp/engine.rb
require 'rails/engine'

module RailsWarp
  class Engine < ::Rails::Engine
    # 将控制器响应封装模块包含到 Rails 的 ActionController::Base 中
    initializer "rails_warp.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include RailsWarp::ResponseWrapper
      end
    end

    # 将 Jbuilder 扩展模块包含到 Jbuilder 类中
    config.after_initialize do |app|
      # Jbuilder 的上下文类通常是 Jbuilder 或 JbuilderTemplate
      # 尝试混入到 Jbuilder 类
      if defined?(Jbuilder)
        Jbuilder.include RailsWarp::JbuilderExtension
      end
      # 如果 JbuilderTemplate 存在，也混入它 (在某些 Jbuilder 版本中可能需要)
      if defined?(JbuilderTemplate)
        JbuilderTemplate.include RailsWarp::JbuilderExtension
      end
    end
  end
end