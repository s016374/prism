module Prism
  module Pages
    module Web
      class Signin < SitePrism::Section
        element :username, '#inputUsername'
        element :password, '#inputPassword'
        element :save_password, '#save-password'
        element :signup, 'div.forgot-password > a.signup-link'
        element :forget_password, 'div.forgot-password > a.forgot-password-link'
        element :login, 'button'
      end

      class Login < SitePrism::Page
        set_url "/auth-service/signin"
        set_url_matcher /signin/

        section :signin, Signin, '#form-signin'

        element :qq, '#form-signin > div.third-login > div.login-area > ul > li:nth-child(1) > a'
        element :wechat, '#form-signin > div.third-login > div.login-area > ul > li:nth-child(2) > a'
      end

      class ForgetPassword < SitePrism::Page
        set_url_matcher /forgetpassword/

        element :ng_valid_form, 'body > div.ng-scope > div > form'
      end
    end
  end
end
