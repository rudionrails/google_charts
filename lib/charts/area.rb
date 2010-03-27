module Rudionrails
  module AwesomeChart

    def area_chart( collection, options = {}, html_options = {}, &block )
      chart = AreaChart.new( self, collection, options, html_options )
      yield( chart )
      concat( chart.to_html )
    end

    class AreaChart < LineChart
    end

  end
end

