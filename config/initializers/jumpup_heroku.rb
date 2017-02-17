Jumpup::Heroku.configure do |config|
  config.app = 'microkiwi'
end if Rails.env.development?
