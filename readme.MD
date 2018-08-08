# selenium + headless + poltergeist + capybara + prism page + rspec + cucumber

## usage:
#CAPYBARA_BROWSER include 'poltergeist' 'selenium_headless_chrome' 'selenium_headless_firefox'  
docker run --rm -t -v $PWD:/opt -e CAPYBARA_BROWSER='selenium_headless_chrome' registry.a.com/ruby/prism:v2
