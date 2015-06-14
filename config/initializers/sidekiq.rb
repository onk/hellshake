connection_config = Global.redis.queue

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{connection_config.host}:#{connection_config.port}/#{connection_config.db}",
    namespace: connection_config.namespace,
  }
end

# When in Unicorn, this block needs to go in unicorn's `after_fork` callback:
Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{connection_config.host}:#{connection_config.port}/#{connection_config.db}",
    namespace: connection_config.namespace,
  }
end
