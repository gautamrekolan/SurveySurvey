# Edit this file to contain all necessary information for mail system setup

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "fragmentlabs.com",
  :user_name            => "alex",
  :password             => "Lak8kxs!",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

# Default host for links included in mailings
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
