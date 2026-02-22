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
    initializer "rails_warp.jbuilder", before: :eager_load! do |app|
      # 显式 require jbuilder 以确保 handler 被注册
      require 'jbuilder'

      # 确保 jbuilder handler 被注册
      if defined?(JbuilderHandler) && !ActionView::Template.registered_template_handler(:jbuilder)
        ActionView::Template.register_template_handler(:jbuilder, JbuilderHandler)
      end

      # 将 JbuilderExtension 包含到 Jbuilder 类
      if defined?(Jbuilder)
        Jbuilder.include(RailsWarp::JbuilderExtension)
      end

      # 某些版本的 jbuilder 使用 Jbuilder::Template
      if defined?(Jbuilder::Template)
        Jbuilder::Template.include(RailsWarp::JbuilderExtension)
      end

      # 兼容旧版本的 JbuilderTemplate
      if defined?(JbuilderTemplate) && defined?(JbuilderTemplate) != defined?(Jbuilder::Template)
        JbuilderTemplate.include(RailsWarp::JbuilderExtension)
      end
    end
  end
end
