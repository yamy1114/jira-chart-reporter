module Ruboty
  module Helpers
    module SeleniumTargets
      class GoogleAuthentication
        SIGNIN_PAGE_URL = 'https://accounts.google.com/signin'
        USE_ANOTHER_ACCOUNT_BUTTON_TEXT = '別のアカウントを使用'
        LOGIN_FACTORS = [
            { type: 'email',    label: 'メールアドレスまたは電話番号' },
            { type: 'password', label: 'パスワードを入力'             }#,
#            { type: 'tel',      label: 'コードを入力'                 }
        ]
 
        def initialize(driver)
          @driver = driver
        end

        def signin
          # 過去ログインアカウントでのログイン選択肢が表示されている場合に他のアカウントでログイン
          begin
            use_another_account_button_element = @driver.find_element(xpath: "//*[text()=\"#{USE_ANOTHER_ACCOUNT_BUTTON_TEXT}\"]")
            use_another_account_button_element.click
          rescue Selenium::WebDriver::Error::NoSuchElementError
            # 要素が見つからない場合そのまま次の処理へ
          end

          # 入力フォームへの値の入力
          LOGIN_FACTORS.each do |factor|
            Proc.new do
              input_element = @driver.find_element(xpath: "//input[@type='#{factor[:type]}']")
              input_text = ask(factor[:label] + ': ') do |q|
                q.echo = '*' if factor[:type] == 'password'
              end
              input_element.send_keys(input_text, :enter)
            end.retry(COMMON_RETRY_RULES)
          end

          # google 認証の終了を確認
          Proc.new do
            raise unless @driver.current_url.match(/#{SIGNIN_PAGE_URL}/)
          end.retry(COMMON_RETRY_RULES)
        end

        include ::Ruboty::Helpers::MethodHookLogger
      end
    end
  end
end
