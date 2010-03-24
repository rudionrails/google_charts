module Rudionrails
  module AwesomeChart

    def line_chart( collection, options = {}, html_options = {}, &block )
      chart = LineChartBuilder.new( self, collection, options, html_options )
      yield( chart )
      concat( chart.to_html )
    end

    class LineChartBuilder < Base
      def initialize( template, collection, options = {}, html_options = {} )
        super

        @label, @values = [], []
      end

      def label( name, method ); @label = [name, method]; end
      def value( name, method ); @values << [name, method]; end

      def to_html
        @html << <<-EOS
        <script type="text/javascript">
          google.load( "visualization", "1", { packages: ["linechart"] } );
          google.setOnLoadCallback( function() {
            var data = new google.visualization.DataTable();

            #{columns.join("\n")}

            data.addRows([ #{rows.join(", ")} ]);

            var chart = new google.visualization.LineChart( document.getElementById('#{@html_options[:id]}') );
            chart.draw( data, #{@options.to_json} );
          });
        </script>
        EOS

        @html.join
      end


      private

      def columns
        html = ["data.addColumn( 'string', '#{@label.first}' );"]
        @values.inject( html ) do |result, value|
          result << "data.addColumn( 'number', '#{value.first}' );"
          result
        end
      end

      def rows
        @collection.inject( Array.new ) do |result, col|
          label = @label.last.is_a?( Proc ) ? @label.last.call( col ) : col.send( @label.last )

          values = @values.inject( Array.new ) do |ary, value|
            puts "************ " + value.inspect
            ary << (value.last.is_a?( Proc ) ? value.last.call( col ) : col.send( value.last ) )
            ary
          end

          result << [label, *values].to_json
          result
        end
      end

    end

  end
end