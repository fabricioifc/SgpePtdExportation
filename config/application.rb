require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PdeIF
  class Application < Rails::Application

    config.generators do |g|
      g.javascript_engine :js
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.encoding = "utf-8"
    config.time_zone = 'Brasilia'

    config.i18n.default_locale = :'pt-BR'
    config.i18n.available_locales = [:en, :"pt-BR"]

    # Novo tema para o painel de administração que utiliza a gem rails_admin
    ENV['RAILS_ADMIN_THEME'] = 'rollincode'

    # Configurações para enviar email em todos os ambientes
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => Rails.application.secrets.domain_name,
      :user_name            => Rails.application.secrets.email_provider_username,
      :password             => Rails.application.secrets.email_provider_password,
      :authentication       => 'plain',
      :enable_starttls_auto => true
    }
  end
end
