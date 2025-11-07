# frozen_string_literal: true

require_relative "lib/rails_warp/version"

Gem::Specification.new do |spec|
  spec.name = "rails_warp"
  spec.version = RailsWarp::VERSION
  spec.authors = ["aric.zheng"] # 替换为你的名字
  spec.email = ["1290657123@qq.com"] # 替换为你的邮箱

  spec.summary = "A Rails plugin for elegant, hash-based response wrapper for clean Rails API responses."
  spec.description = "Provides `ok` and `fail` methods in controllers for standardized API responses. Includes jbuilder helpers."
  spec.homepage = "https://github.com/afeiship/rails_warp" # 替换为你的项目地址
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage # 假设主页就是源码地址
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # 添加对 jbuilder 的依赖 (如果需要)
  spec.add_dependency "jbuilder", ">= 2.5"
end