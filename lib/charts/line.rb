module Rudionrails
  module GoogleCharts

    def line_chart( collection, options = {}, html_options = {}, &block )
      chart = LineChart.new( self, collection, options, html_options )
      yield( chart )
      concat( chart.to_html )
    end

    class LineChart < Base
      def initialize( template, collection, options = {}, html_options = {} )
        super

        @label, @values = [], []
      end

      def label( name, method ); @label = [name, method]; end
      def value( name, method ); @values << [name, method]; end
      
      
      protected

      def setup_data
        # setup the columns
        add_column( 'string', @label.first )
        @values.each { |val| add_column( 'number', val.first ) }
        
        # setup the rows
        @collection.each do |col|
          label = value_for( @label.last, col )
          values = @values.map { |value| value_for( value.last, col ) }
          
          add_row( [label, *values] )
        end
      end

    end

  end
end

