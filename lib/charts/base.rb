module Rudionrails
  module AwesomeChart

    class Base

      def initialize( template, collection, options = {}, html_options = {} )
        @template = template
        @collection = collection
        @options = options
        @html_options = html_options.reverse_merge( :id => "awesomeChart" )
      end

      def title( val ); @options[:title] = val; end

      def to_html
        [ google_js_api, container_div, google_chart ].join("\n")
      end

      
      protected

      def google_js_api
        @template.javascript_tag(
          <<-EOS
          if( typeof google == 'undefined' ) {
            document.write(unescape("%3Cscript src='http://www.google.com/jsapi' type='text/javascript'%3E%3C/script%3E"));
          };
          EOS
        )
      end

      def google_chart
        @template.javascript_tag(
          <<-EOS
          google.load( "visualization", "1", { packages: #{packages} } );
          google.setOnLoadCallback( function() {
            var data = new google.visualization.DataTable();

            #{data_columns}
            #{data_rows}

            var chart = new google.visualization.#{class_name}( document.getElementById('#{@html_options[:id]}') );
            chart.draw( data, #{@options.to_json} );
          });
          EOS
        )
      end
      
      def container_div
        @template.content_tag( :div, "", :id => @html_options[:id] )
      end

      # stubs
      def data_columns; end
      def data_rowsl; end

      def class_name; self.class.name.split( "::" ).last; end
      def packages; [class_name.downcase].to_json end

    end

  end
end

