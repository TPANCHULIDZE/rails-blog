set :output, "log/cron.log"
set :environment, "development"


every 1.minute do
  rake 'delete:post'
end
