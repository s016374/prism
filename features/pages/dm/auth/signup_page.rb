module Prism
  module Pages
    module DM
      class Signup < SitePrism::Page
        set_url_matcher /signup/

        element :signup_form, 'body > div > div > div > form'
      end

      class QqAuth < SitePrism::Page
        set_url_matcher /qq/

        element :auth_manager_link, '#auth_manager_link'
      end

      class WechatAuth < SitePrism::Page
        set_url_matcher /weixin/

        element :qrcode, 'body > div > div > div.waiting.panelContent > div.wrp_code > img'
      end
    end
  end
end
