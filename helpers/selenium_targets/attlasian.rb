module Ruboty
  module Helpers
    module SeleniumTargets
      class Attlasian
        LOGIN_PAGE_URL                   = 'https://id.atlassian.com/login'
        BURNUP_CHART_PAGE_URL            = 'https://nttcom.atlassian.net/secure/RapidBoard.jspa?rapidView=34&projectKey=BEAR&view=reporting&chart=burnupChart'
        BURNUP_CHART_ELEMENT_ID          = 'ghx-sprint-burnup-report'
        GOOGLE_SIGNIN_BUTTON_ELEMENT_ID  = 'google-signin-button'
        SPRINT_GOAL_ELEMENT_CLASS        = 'ghx-sprint-goal'
        BURNUP_CHART_DRAWING_WAIT_SECOND = 5

        def initialize(driver)
          @driver = driver
        end

        def is_login_page?
          !!@driver.current_url.match(/#{Regexp.escape(LOGIN_PAGE_URL)}/)
        end

        def login_via_google
          @driver.find_element(id: GOOGLE_SIGNIN_BUTTON_ELEMENT_ID).click
          GoogleAuthentication.new(@driver).signin
        end

        def wait_until_transition_to_burndup_chart_page
          Proc.new do
            raise unless @driver.current_url.match(/#{Regexp.escape(BURNUP_CHART_PAGE_URL)}/)
          end.retry(COMMON_RETRY_RULES)
          sleep BURNUP_CHART_DRAWING_WAIT_SECOND
        end

        def get_burnup_chart_rectangle
          @driver.find_element(id: BURNUP_CHART_ELEMENT_ID).rect
        end

        def get_sprint_goal
          @driver.find_element(class: SPRINT_GOAL_ELEMENT_CLASS).text
        end

        include ::Ruboty::Helpers::MethodHookLogger
      end
    end
  end
end
