module Prism
  module Pages
    module DM
      class Dashboard < SitePrism::Page
        set_url "/dashboard"
        set_url_matcher /dashboard/

        element :logo, 'body > nav > div > div.navbar-header > img'
      end
    end
  end
end
