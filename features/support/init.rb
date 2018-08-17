require 'pry-byebug'
require 'capybara'
require 'capybara/cucumber'
require 'capybara/rspec'
require 'site_prism'

# module Prism
#   if ENV['WEB_OR_APP'] =~ /web/
#     require_relative "#{Dir.pwd}/features/libs/browser"
#     # init_browser
#     # init_browser_with_cookie
#   elsif ENV['WEB_OR_APP'] =~ /app/
#     require_relative "#{Dir.pwd}/features/libs/device"
#     init_device
#     promote_methods
#   else
#     raise 'WEB_OR_APP is unvaild.'
#   end
# end
