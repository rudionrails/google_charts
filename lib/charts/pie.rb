module Rudionrails
  module AwesomeChart
    
    def pie_chart( collection, options = {}, html_options = {}, &block )
      chart = PieChartBuilder.new( self, collection, options, html_options )
      yield( chart )
      concat( chart.to_html )
    end

    class PieChartBuilder < Base
      def initialize( template, collection, options = {}, html_options = {} )
        super
        
        @label, @value = [], []
      end

      def label( name, method ); @label = [name, method]; end
      def value( name, method ); @value = [name, method]; end
      
      
      protected

      def google_chart
        @template.javascript_tag(
          <<-EOS
          google.load( "visualization", "1", { packages: ["piechart"] } );
          google.setOnLoadCallback( function() {
            var data = new google.visualization.DataTable();

            #{data_columns}
            #{data_rows}

            var chart = new google.visualization.PieChart( document.getElementById('#{@html_options[:id]}') );
            chart.draw( data, #{@options.to_json} );
          });
          EOS
        )
      end


      private
      
      def data_columns
        [
          "data.addColumn( 'string', '#{@label.first}' );", 
          "data.addColumn( 'number', '#{@value.first}' );" 
        ].join( "\n" )
      end

      def data_rows
        html = [ "data.addRows([ " ]
      
        html << @collection.inject( Array.new ) do |result, col|
          label = @label.last.is_a?( Proc ) ? @label.last.call( col ) : col.send( @label.last )
          value = @value.last.is_a?( Proc ) ? @value.last.call( col ) : col.send( @value.last )

          result << [label, value].to_json
          result
        end.join( ", " )
        
        html << "]);"
        
        html.join( "\n" )
      end

    end

  end
end
