require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'http'

# local chorme for debug
Capybara.register_driver :chrome_local do |app|
  Selenium::WebDriver::Chrome.driver_path = File.join(File.absolute_path(ENV['LOCAL_BROWSER_PATH']))
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# Poltergeist is a driver for Capybara, provided by PhantomJS.
# It allows you to run your Capybara tests on a headless WebKit browser.
Capybara.register_driver :poltergeist_local do |app|
  Capybara::Poltergeist::Driver.new(app, inspector: true)
end

# remote selenium hub connect chrome
Capybara.register_driver :selenium_headless_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: { args: %w[headless disable-gpu] }),
    url: ENV['CAPYBARA_SELENIUM_HUB']
  )
end

# remote selenium hub connect firefox
Capybara.register_driver :selenium_headless_firefox do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.firefox,
    url: ENV['CAPYBARA_SELENIUM_HUB']
  )
end

####
# # - Deprecated:
# # headless browser init
# @headless ||= Headless.new if ENV['CAPYBARA_BROWSER']
# @headless.start
#
# # Note: Headless will NOT hide most applications on OS X
# # local local_headless_firefox
# Capybara.register_driver :local_headless_firefox do |app|
#   Selenium::WebDriver.for :firefox
#   Capybara::Selenium::Driver.new(app, :browser => :firefox)
# end
#
# # local local_headless_firefox
# Capybara.register_driver :local_headless_chrome do |app|
#   Selenium::WebDriver.for :chrome
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end
####

def init_browser
  Capybara.default_driver = ENV['CAPYBARA_BROWSER'].to_sym
  # script driver
  Capybara.javascript_driver =  case ENV['CAPYBARA_BROWSER']
                                when /poltergeist/
                                  :poltergeist
                                when /headless_chrome/
                                  :headless_chrome
                                when /headless_firefox/
                                  :headless_firefox
                                end
end

def init_browser_with_cookie
  sid = get_cookie ENV['TEST_USERNAME'], ENV['TEST_PASSWORD']
  # init_browser
  # must visit a site
  visit ENV['BASE_URL']
  if ENV['CAPYBARA_BROWSER'] =~ /poltergeist/
    browser_manager = Capybara.current_session.driver
    # must add domain, otherwise request backend api error.
    browser_manager.set_cookie(:sid, sid, domain: '.innodealing.com')
    browser_manager.set_cookie(:uid, ENV['COOKIE_UID'], domain: '.innodealing.com')
  else
    browser_manager = Capybara.current_session.driver.browser.manage
    # must clean cookie, otherwise there are two SID.
    browser_manager.delete_all_cookies
    # must add domain, otherwise request backend api error.
    browser_manager.add_cookie(name: :sid, value: sid, domain: '.innodealing.com')
    browser_manager.add_cookie(name: :uid, value: ENV['COOKIE_UID'], domain: '.innodealing.com')
  end
end

private
def get_cookie(username, password, is_hash=false)
  url = "#{ENV['BASE_URL']}/auth-service/signin"
  res = HTTP.get(url)
  csrf = res.to_s.split('name="_csrf" value="').last.split('"/>').first
  sid = res.cookies.inspect.to_s.split('"sid", value="').last.split('",').first
  res = HTTP[content_type: 'application/x-www-form-urlencoded']
            .cookies('sid' => sid)
            .post(url, :body => "_csrf=#{csrf}&username=#{username}&password=#{password}")
  sid = res.cookies.inspect.to_s
  return 'auth error' if sid.include? '@jar={}'
  sid = sid.split('"sid", value="').last.split('",').first
  return sid unless is_hash
  { sid: sid, uid: ENV['COOKIE_UID'] }
end
