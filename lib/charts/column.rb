module Rudionrails
  module AwesomeChart

    def column_chart( collection, options = {}, html_options = {}, &block )
      chart = ColumnChart.new( self, collection, options, html_options )
      yield( chart )
      concat( chart.to_html )
    end

    class ColumnChart < LineChart

      protected

      def packages; ["columnchart"].to_json; end

    end

  end
end


