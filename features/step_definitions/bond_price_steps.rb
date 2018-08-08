include Prism::Helper

Given(/^visit bond yieldbond$/) do
  @bond_price_yield_bond = @app.bond_price_yield_bond
  @bond_price_yield_bond.load { wait_when_using_poltergeist }
  @bond_price_yield_bond.wait_for_bond_market_credit_today
  @bond_price_yield_bond.wait_for_bond_screener_navigator_filter_name
end

When(/^click yieldbond Bid$/) do
  @bond_price_yield_bond.bond_market_credit_today.yieldbond_bid.click
end

When(/^click yieldbond Ofr$/) do
  @bond_price_yield_bond.bond_market_credit_today.yieldbond_ofr.click
end

When(/^click yieldbond deal price$/) do
  @bond_price_yield_bond.bond_market_credit_today.yieldbond_deal_price.click
end

When(/^click valuation$/) do
  @bond_price_yield_bond.bond_screener_navigator_filter_name.valuation.click
end

Then(/^check yeildbond_count > '(\d+)'$/) do |num|
  count =  @bond_price_yield_bond.bond_market_credit_today.yeildbond_count.text
  count.to_i.should be >= num
end

Given(/^visit bond valuation$/) do
  @bond_price_valuation = @app.bond_price_valuation
  @bond_price_valuation.load
  @bond_price_valuation.wait_for_bond_market_credit_today
  @bond_price_valuation.wait_for_bond_screener_navigator_filter_name
end

When(/^click valuation Bid$/) do
  @bond_price_valuation.bond_market_credit_today.valuation_bid.click
end

When(/^click valuation Ofr$/) do
  @bond_price_valuation.bond_market_credit_today.valuation_ofr.click
end

When(/^click valuation deal price$/) do
  @bond_price_valuation.bond_market_credit_today.valuation_deal_price.click
end

When(/^click yieldbond$/) do
  @bond_price_valuation.bond_screener_navigator_filter_name.yield_bond.click
end
