require_relative 'bond_common'

module Prism
  module Pages
    module DM
      class BondPriceYieldBond < SitePrism::Page
        set_url "/newdm-beta/#/main/bond/market/price/yieldbond"
        set_url_matcher /bond\/market\/price\/yieldbond/

        section :bond_market_credit_today, BondMarketCreditToday
        section :bond_screener_navigator_filter_name, BondScreenerNavigatorFilterName
      end

      class BondPriceValuation < SitePrism::Page
        set_url "/newdm-beta/#/main/bond/market/price/valuation"
        set_url_matcher /bond\/market\/price\/valuation/

        section :bond_market_credit_today, BondMarketCreditToday
        section :bond_screener_navigator_filter_name, BondScreenerNavigatorFilterName
      end
    end
  end
end
