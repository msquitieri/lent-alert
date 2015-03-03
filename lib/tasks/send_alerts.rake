namespace :alerts do
  desc "Send Lent Alert to all users at the time when called."
  task :send => :environment do
    time = Time.current.utc
    hour = time.hour
    minute = time.strftime('%M').to_i

    puts "Sending Alerts to those with hour #{hour} and minute #{minute}"
    users = User.with_hour(hour).with_minute(minute)
    puts "Sending Alerts to #{users.count} users."

    users.each do |user|
      user.send_alert
    end

    puts "Done."
  end
end