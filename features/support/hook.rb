Before do |_scenario|
  init_browser
  @app = Prism::App.new
end

Before('~@signin') do |_scenario|
  init_browser_with_cookie
end

###
#- Deprecated:
#- This works as well, but it's more show than 'Before' below.
#
# Before('~@signin') do |_scenario|
#   @login = @app.login
#   @login.load
#   @login.signin.username.set ENV['TEST_USERNAME']
#   @login.signin.password.set ENV['TEST_PASSWORD']
#   @login.signin.login.click
# end
###

After do |_scenario|
  if _scenario.failed? && !ENV['CAPYBARA_BROWSER'].include?('headless')
    screenshot_file = "screenshot_#{Time.now.strftime("%Y-%m-%d-%H%M")}.png"
    # save screenshot
    Capybara.current_session.save_screenshot screenshot_file
    # attached screenshot to report
    embed "screenshots/#{screenshot_file}", 'image/png'

    # request fireman api, fireman handle and notice octopus.
    report_issue_to_fireman(_scenario.name) unless ENV['FIREMAN_REPORT'].nil?
  end
end

at_exit do
  ###
  #- Deprecated:
  # @headless.destroy unless @headless.nil?
  ###

  # @browser.stop unless @browser.nil?
end

private
# curl -u user:passwd -X 'POST' -d '{error description}' http://fireman_host/issue
# curl -u user:passwd -X 'DELETE' http://fireman_host/issue/issue_id
# curl -u user:passwd -X 'DELETE' http://fireman_host/issues/clean
def report_issue_to_fireman(scenario)
  url = "#{ENV['FIREMAN_HOST']}/issue"
  report = { msg: "[Prism E] scenario: #{scenario}" }
  HTTP.basic_auth(user: ENV['FIREMAN_USER'], pass: ENV['FIREMAN_PASSWORD']).post(url, json: report)
end
