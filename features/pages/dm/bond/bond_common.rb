module Prism
  module Pages
    module DM
      class BondMarketCreditToday < SitePrism::Section
        set_default_search_arguments '#bond-container > div.bond-market-container.ng-scope > div > div.bond-market-credittoday-container.ng-scope > div'

        element :yieldbond_deal_price, 'div.bond-market-industry-filter > span.btn-group.market-filter-source > label:nth-child(1)'
        element :yieldbond_bid, 'div.bond-market-industry-filter > span.btn-group.market-filter-source > label:nth-child(2)'
        element :yieldbond_ofr, 'div.bond-market-industry-filter > span.btn-group.market-filter-source > label:nth-child(3)'
        element :yeildbond_count, 'div.bond-market-credittoday-container.ng-scope > div > div.bond-market-attention-container.ng-scope > div.bond-market-attention-header > span:nth-child(5) > span'

        element :valuation_deal_price, 'div.bond-market-credittoday-container.ng-scope > div > div.bond-market-industry-filter > span.btn-group.market-pricevalue-filter-source > label:nth-child(1)'
        element :valuation_bid, 'div.bond-market-credittoday-container.ng-scope > div > div.bond-market-industry-filter > span.btn-group.market-pricevalue-filter-source > label:nth-child(2)'
        element :valuation_ofr, 'div.bond-market-credittoday-container.ng-scope > div > div.bond-market-industry-filter > span.btn-group.market-pricevalue-filter-source > label:nth-child(3)'

      end

      class BondScreenerNavigatorFilterName < SitePrism::Section
        set_default_search_arguments '#bond-container > div.bond-market-container.ng-scope > div > div.bond-screener-navigator > div'

        element :yield_bond, 'div.bond-screener-navigator > div > div:nth-child(1) > span'
        element :valuation, 'div.bond-screener-navigator > div > div:nth-child(2) > span'
      end
    end
  end
end
