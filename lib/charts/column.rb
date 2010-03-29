module Rudionrails
  module GoogleCharts

    def column_chart( collection, options = {}, html_options = {}, &block )
      chart = ColumnChart.new( self, collection, options, html_options )
      yield( chart )
      concat( chart.to_html )
    end

    class ColumnChart < LineChart
    end

  end
end

