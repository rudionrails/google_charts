module Rudionrails
  module AwesomeChart

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

      def packages; ["linechart"].to_json; end

      def data_columns
        html = [ "data.addColumn( 'string', '#{@label.first}' );" ]
        @values.inject( html ) do |result, value|
          result << "data.addColumn( 'number', '#{value.first}' );"
          result
        end.join( "\n" )
      end

      def data_rows
        html = [ "data.addRows([ " ]
        
        html << @collection.inject( Array.new ) do |result, col|
          label = @label.last.is_a?( Proc ) ? @label.last.call( col ) : col.send( @label.last )

          values = @values.inject( Array.new ) do |ary, value|
            ary << (value.last.is_a?( Proc ) ? value.last.call( col ) : col.send( value.last ) )
            ary
          end

          result << [label, *values].to_json
          result
        end.join( ", " )
        
        html << "]);"
        
        html.join( "\n" )
      end

    end

  end
end

