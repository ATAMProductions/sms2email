uri = URI.parse(ENV["REDISTOGO_URL"])
Resque = Redis.new(:url => ENV['REDISTOGO_URL'])