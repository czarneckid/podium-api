require 'redis'
require 'leaderboard'

case ENV['RACK_ENV']
when 'production'
  # Replace this with an appropriate Redis instance for production
else
  $redis = Redis.new
end

redis_options = {:redis_connection => $redis}
$highscore_lb = Leaderboard.new('highscores', {:page_size => 5, :reverse => false}, redis_options)