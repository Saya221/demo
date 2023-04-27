SG = SendGrid::API.new api_key: ENV["SENDGRID_API_KEY"]

ActionMailer::Base.smtp_settings = {
  address: ENV.fetch("SMTP_ADDRESS", "smtp.sendgrid.net"),
  port: ENV.fetch("SMTP_PORT", 587),
  domain: ENV.fetch("SMTP_DOMAIN", "localhost:3000"),
  user_name: ENV.fetch("SMTP_USER_NAME", "apikey"),
  password: ENV["SENDGRID_API_KEY"],
  authentication: :plain,
  enable_starttls_auto: true
}
