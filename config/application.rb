require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))

  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module KalendarniPlan
  class Application < Rails::Application
   config.action_view.field_error_proc = Proc.new { |html_tag, instance| "<span class='field_with_errors'>#{html_tag}</span>".html_safe }
  config.time_zone = 'Moscow'

    config.i18n.default_locale = :ru

    config.encoding = "utf-8"

 
    config.filter_parameters += [:password]

   
    config.assets.enabled = true

  
    config.assets.version = '1.0'

    config.assets.precompile += ['sh/*.js', 'blueprint/*.css']
  end
end
