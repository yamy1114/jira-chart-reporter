module Ruboty
  module Actions
    class BurnupChart < Base
      include ::Ruboty::Helpers::SeleniumTargets

      def call
        message.reply('burnup chart 用意するくま')
        Proc.new do
          save_burnup_chart_page_screenshot
        end.retry(COMMON_RETRY_RULES)
        trim_screenshot
        message.reply(
          '',
          file: {
            path: TRIMMED_FILE_PATH,
            title: @sprint_goal
          }
        )
      rescue StandardError => ex
        message.reply('燃え尽きたくま…')
        p ex
      end

      private
      
      def save_burnup_chart_page_screenshot
        driver = Selenium::WebDriver.for :chrome, options: chrome_options
        driver.manage.window.resize_to(WINDOW_WIDTH, WINDOW_HEIGHT)
        driver.get(Attlasian::BURNUP_CHART_PAGE_URL)

        attlasian_page = Attlasian.new(driver)
        if attlasian_page.is_login_page?
          message.reply('ターミナルからログイン情報を入力してね')
          attlasian_page.login_via_google
        end
        attlasian_page.wait_until_transition_to_burndup_chart_page

        @burnup_chart_rect = attlasian_page.get_burnup_chart_rectangle
        @sprint_goal = attlasian_page.get_sprint_goal
        driver.save_screenshot(SCREENSHOT_FILE_PATH)

        driver.close
      rescue StandardError
        driver.close()
        raise 'failed to save screenshot'
      end

      def trim_screenshot
        image = MiniMagick::Image.open(SCREENSHOT_FILE_PATH)
        image.resize("#{WINDOW_WIDTH}x#{WINDOW_HEIGHT}")
        image.crop("#{@burnup_chart_rect.width}x#{@burnup_chart_rect.height}+#{@burnup_chart_rect.x}+#{@burnup_chart_rect.y}")
        image.write(TRIMMED_FILE_PATH)
      end

      include Helpers::MethodHookLogger
    end
  end
end
