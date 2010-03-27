module Rudionrails
  module AwesomeChart

    def bar_chart( collection, options = {}, html_options = {}, &block )
      chart = BarChart.new( self, collection, options, html_options )
      yield( chart )
      concat( chart.to_html )
    end

    class BarChart < LineChart
    end

  end
end

