::SecureHeaders::Configuration.default do |config|
  config.hsts = "max-age=#{20.years.to_i}; includeSubdomains"
  config.x_frame_options = 'DENY'
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.csp = SecureHeaders::OPT_OUT
end
