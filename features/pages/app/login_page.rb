module Prism
  module Pages
    module App
      class Login < SitePrism::Page
        elements :navigation_bar, :accessibility_id, 'UICatalog'

        def self.drag_splash_screen
          3.times { swipe direction: 'left' }
        end
      end
    end
  end
end
