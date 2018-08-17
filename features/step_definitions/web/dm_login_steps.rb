Given(/^visit dm$/) do
  @login = @app.login
  @login.load
end

Then (/^https works$/) do
  expect(@login).to be_secure
end

Then (/^right page title$/) do
  expect(@login.title).to eq('DM登录')
end

Then (/^page load success$/) do
  expect(@login).to be_displayed
end

When (/^click qq$/) do
  @login.qq.click
end

Then(/^enter qq auth$/) do
  qq_auth = @app.qq_auth
  expect(qq_auth).to be_displayed
  expect(qq_auth).to have_auth_manager_link
end

When (/^click wechat$/) do
  @login.wechat.click
end

Then(/^enter wechat auth$/) do
  wechat_auth = @app.wechat_auth
  expect(wechat_auth).to be_displayed
  expect(wechat_auth).to have_qrcode
end

When(/^click signup$/) do
  @signup_window = window_opened_by { @login.signin.signup.click }
end

Then(/^enter signup page$/) do
  signup = @app.signup
  within_window @signup_window do
    expect(signup).to be_displayed
    expect(signup).to have_signup_form
  end
end

When(/^click forgetpassword$/) do
  @forget_password_window = window_opened_by { @login.signin.forget_password.click }
end

Then(/^enter forgetpassword page$/) do
  forget_password = @app.forget_password
  within_window @forget_password_window do
    expect(forget_password).to be_displayed
    expect(forget_password).to have_ng_valid_form
  end
end

When (/^input username$/) do
  @login.signin.username.set ENV['TEST_USERNAME']
end

And (/^input password$/) do
  @login.signin.password.set ENV['TEST_PASSWORD']
end

And (/^click login$/) do
  @login.signin.login.click
end

Then (/^enter dashboard page$/) do
  dashboard = @app.dashboard
  expect(dashboard).to be_displayed
  expect(dashboard).to have_logo
end
