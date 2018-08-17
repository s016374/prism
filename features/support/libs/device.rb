require 'appium_capybara'

desired_caps_ios = {
  # If automationName is Appium or nil, then they provide UIAxxxx
  # If automationName is XCUITest, then they provide XCUIElementTypexxx
  platformName: "iOS",
  automationName: ENV['IOS_AUTOMATION_NAME'] || 'XCUITest',
  deviceName: ENV['IOS_DEVICE'] || 'iPhone X',
  platformVersion: ENV['IOS_FLATFORM_VERSION'] || '11.4',
  app: ENV['IOS_BUILD_PATH']
}

Capybara.register_driver(:appium_ios_local) do |app|
  appium_lib_options = { server_url: ENV['APPIUM_URL'] }
  all_options = {
    appium_lib: appium_lib_options,
    caps: desired_caps_ios,
    global_driver: false
  }
  Appium::Capybara::Driver.new app, all_options
end

desired_caps_android = {
  platformName: 'Android',
  automationName: ENV['ANROID_AUTOMATION_NAME'] || 'UIAutomator2',
  deviceName: ENV["ANDROID_DEVICE_VERSION"] || 'Android',
  platformVersion: ENV["ANDROID_PLATFORM_VERSION"] || '8',
  app: ENV['ANDROID_BUILD_PATH']
}

Capybara.register_driver(:appium_android_local) do |app|
  appium_lib_options = { server_url: ENV['APPIUM_URL'] }
  all_options = {
    appium_lib: appium_lib_options,
    caps: desired_caps_android,
    global_driver: false
  }
  Appium::Capybara::Driver.new app, all_options
end

def init_device
  Capybara.current_driver = ENV['APPIUM_CAPYBARA_BROWSER'].to_sym
  $driver = Capybara.current_session.driver.appium_driver
end

def promote_methods
  # Pages::Home.drag_splash_screen
  Appium.promote_singleton_appium_methods Prism::Pages::Ios
  Appium.promote_singleton_appium_methods Prism::Pages::Android

  # Pages::Home.new.drag_splash_screen
  # Appium.promote_appium_methods SitePrism::Page
end
