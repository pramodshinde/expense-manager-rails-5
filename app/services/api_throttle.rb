class ApiThrottle
  class << self

    def api_limit?(key, limit = 3)
      self.increment(key) > limit
    end

    def increment(key)
      client = Redis.new
      limit = client.incr(key.to_s)
      limit
    end

    def available_limit(key, total_limit)
      client = Redis.new
      used_limit = client.get(key).to_i
      remaining_limit = used_limit.zero? ? 1 : used_limit + 1
      (total_limit - remaining_limit) < 0 ? 0 : (total_limit - remaining_limit) 
    end
  end
end
