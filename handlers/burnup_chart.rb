module Ruboty
  module Handlers
    class BurnupChart < Base
      on(
        /burnup|burnup_chart/i,
        name: 'burnup_chart',
        description: 'show image of burnup chart'
      )

      def burnup_chart(message)
        Ruboty::Actions::BurnupChart.new(message).call
      end
    end
  end
end
