# selenium + headless + poltergeist + appium + capybara + prism page + rspec + cucumber

## usage:
#CAPYBARA_BROWSER include 'poltergeist' 'selenium_headless_chrome' 'selenium_headless_firefox'  
#APPIUM_CAPYBARA_BROWSER include 'appium_android' 'appium_ios'
docker run --rm -t -v $PWD:/opt -e CAPYBARA_BROWSER='selenium_headless_chrome' -e APPIUM_CAPYBARA_BROWSER='appium_ios' registry.a.com/ruby/prism:v2
