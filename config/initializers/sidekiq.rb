Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV.fetch(ENV.fetch("REDIS_PROVIDER", "REDIS_URL"), "redis://localhost:6379/1"),
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }, # We must trust Heroku here
  }
end
