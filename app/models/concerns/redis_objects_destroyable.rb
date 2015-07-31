# destroy 時に redis の key も同時に削除する
module RedisObjectsDestroyable
  extend ActiveSupport::Concern

  included do
    after_destroy :delete_redis_keys
  end

  private

    def delete_redis_keys
      self.class.redis_objects.keys.each do |key|
        redis.del(redis_field_key(key))
      end
    end
end
