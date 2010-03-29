module Rudionrails
  module GoogleCharts
    
    def pie_chart( collection, options = {}, html_options = {}, &block )
      chart = PieChart.new( self, collection, options, html_options )
      yield( chart )
      concat( chart.to_html )
    end

    class PieChart < Base
      def initialize( template, collection, options = {}, html_options = {} )
        super
        
        @label, @value = [], []
      end

      def label( name, method ); @label = [name, method]; end
      def value( name, method ); @value = [name, method]; end


      protected

      def setup_data
        # setup the columns
        add_column( 'string', @label.first )
        add_column( 'number', @value.first )

        # setup the rows
        @collection.each do |col|
          add_row( [value_for( @label.last, col ), value_for( @value.last, col )] )
        end
      end

    end

  end
end

