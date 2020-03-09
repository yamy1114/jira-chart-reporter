module Ruboty
  module Helpers
    module SeleniumTargets
      USER_DATA_DIR_PATH = Dir.pwd + '/profile'
      COMMON_RETRY_RULES = { max: 2, wait: 5, accept_exception: StandardError}

      def chrome_options
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument("--user-data-dir=#{USER_DATA_DIR_PATH}")
        options.add_argument('--headless')
        options
      end
    end
  end
end
