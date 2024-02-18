require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Forum

  LANES = %w[Top Jungle Mid Adc Support]

  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
config.autoload_paths += %W(#{config.root}/app/controllers)
    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))
    config.autoload_paths += %W(#{config.root}/app/controllers)
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

   
    
    config.to_prepare do
      Dir.glob(Rails.root.join('app', 'controllers', '**', '*_controller.rb')).each do |controller_path|
        require_dependency controller_path
      end
    end
  end
end
