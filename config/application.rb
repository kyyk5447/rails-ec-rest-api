require_relative 'boot'

require 'rails/all'

# キャメルケース変換のカスタムミドルウェアを読み込み
require_relative '../app/middleware/camel_case_transformer'

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w[assets tasks])
    config.api_only = true
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.session_store :cookie_store, key: '_ec_site_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
    config.middleware.use CamelCaseTransformer
    config.hosts << 'rails-ec-rest-api.onrender.com' if Rails.env.production?
  end
end
