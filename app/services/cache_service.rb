# frozen_string_literal: true

class CacheService
  @@cache = ActiveSupport::Cache::MemoryStore.new

  def set_cache(key, value)
    @@cache.write(key.to_s, value.to_s)
  end

  def fetch_cache(key)
    @@cache.read(key.to_s)
  end

  def cache_exists?(key)
    @@cache.exist?(key.to_s)
  end
end
