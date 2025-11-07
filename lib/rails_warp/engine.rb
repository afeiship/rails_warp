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

    # 注意：Jbuilder 的扩展已经在 after_initialize 中处理
  end
end