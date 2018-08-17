require 'appium_capybara'

# module Prism
#   module Devices
#     module Mobiles
      desired_caps_ios = {
        # If automationName is Appium or nil, then they provide UIAxxxx
        # If automationName is XCUITest, then they provide XCUIElementTypexxx
        automationName:  ENV['AUTOMATION_NAME'],
        deviceName:      ENV['IOS_DEVICE'],
        platformName:    "iOS",
        platformVersion: ENV['IOS_FLATFORM_VERSION'],
        app:             ENV['IOS_BUILD_PATH']
      }

      Capybara.register_driver(:appium_local) do |app|
        appium_lib_options = { server_url: ENV['APPIUM_URL'] }
        all_options = {
          appium_lib: appium_lib_options,
          caps: desired_caps_ios,
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
        Appium.promote_singleton_appium_methods Prism::Pages::App

        # Pages::Home.new.drag_splash_screen
        # Appium.promote_appium_methods SitePrism::Page
      end
#     end
#   end
# end
