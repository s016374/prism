@web
@bond_price
@bond
@trunk
Feature: 债券-异常价格
  Scenario: 进入 债券-异常价格
    Given visit bond yieldbond
    When click yieldbond Bid
    Then check yeildbond_count > '0'
    When click yieldbond Ofr
    Then check yeildbond_count > '0'
    When click yieldbond deal price
    Then check yeildbond_count > '0'
    When click valuation

  Scenario: 进入 债券-估值偏离
    Given visit bond valuation
    When click valuation Bid
    When click valuation Ofr
    When click valuation deal price
    When click yieldbond
