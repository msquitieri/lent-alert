SMTP_SETTINGS = {
  address: ENV.fetch("LA_SMTP_ADDRESS"), # example: "smtp.sendgrid.net"
  authentication: :plain,
  domain: ENV.fetch("LA_SMTP_DOMAIN"), # example: "heroku.com"
  enable_starttls_auto: true,
  password: ENV.fetch("LA_SMTP_PASSWORD"),
  port: "587",
  user_name: ENV.fetch("LA_SMTP_USERNAME")
}
