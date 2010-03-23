module Rudionrails
  module AwesomeChart

    def pie_chart( collection, options = {}, html_options = {}, &block )
      chart = PieChart.new( self, collection, options, html_options )
      yield( chart )
      concat( chart.to_html )
    end

    class PieChart
      def initialize( template, collection, options = {}, html_options = {} )
        @template = template
        @collection = collection
        @options = options
        @html_options = html_options.reverse_merge( :id => "awesomePieChart" )
        
        @label, @value = [], []
        @html = [include_google_api]
      end

      def title( val ); @options[:title] = val; end

      def label( name, method ); @label = [name, method]; end
      def value( name, method ); @value = [name, method]; end

      def to_html
        @html << <<-EOS
        <script type="text/javascript">
          google.load( "visualization", "1", { packages: ["piechart"] } );
          google.setOnLoadCallback( function() {
            var data = new google.visualization.DataTable();

            data.addColumn( 'string', '#{@label.first}' );
            data.addColumn( 'number', '#{@value.first}' );

            data.addRows([ #{data.join(", ")} ]);

            var chart = new google.visualization.PieChart( document.getElementById('#{@html_options[:id]}') );
            chart.draw( data, #{@options.to_json} );
          });
        </script>

        <div id="#{@html_options[:id]}"></div>
        EOS

        @html.join
      end


      private

      def data
        @collection.inject( Array.new ) do |result, col|
          label = @label.last.is_a?( Proc ) ? @label.last.call( col ) : col.send( @label.last )
          value = @value.last.is_a?( Proc ) ? @value.last.call( col ) : col.send( @value.last )

          result << "['#{label}', #{value}]"
          result
        end
      end

      def include_google_api
        <<-EOS
        <script type="text/javascript">
          if( typeof google == 'undefined' ) {
            document.write(unescape("%3Cscript src='http://www.google.com/jsapi' type='text/javascript'%3E%3C/script%3E"));
          };
        </script>
        EOS
      end
    end

  end
end
