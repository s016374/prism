Capybara.configure do |config|
  # default driver
  # config.default_driver = :selenium_headless_chrome
  # screenshot save path
  config.save_path = "#{Dir.pwd}/screenshots"
  # run a server or not
  config.run_server = false
  # max wait time
  config.default_max_wait_time = ENV['CAPYBARA_MAX_WAIT_TIME'].to_i || 2
  # root url
  config.app_host = ENV['BASE_URL']
end
