@web
@trunk
@signin
Feature: DM login

  Background:
    Given visit dm

  Scenario: login page elements works
    Then https works
    Then page load success
    Then right page title

  @signup
  Scenario: qq login
    When click qq
    Then enter qq auth

  @signup
  Scenario: wechat login
    When click wechat
    Then enter wechat auth

  @signup
  Scenario: signup
    When click signup
    Then enter signup page

  @forgetpassword
  Scenario: forget password
    When click forgetpassword
    Then enter forgetpassword page

  Scenario: signin
    When input username
    And input password
    And click login
    Then enter dashboard page
