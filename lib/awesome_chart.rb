module Rudionrails
  module AwesomeChart

    VERSION = "0.0.1.0"

    class Base

      def initialize( template, collection, options = {}, html_options = {} )
        @template = template
        @collection = collection
        
        @options = options
        @html_options = html_options.reverse_merge( :id => "awesomeChart" )

        @columns, @rows = [], []
      end


      def title( val ); @options[:title] = val; end

      def to_html
        setup_data
        
        [ 
          google_jsapi,
          container_div,
          google_chart 
        ].join("\n")
      end


      protected

      def class_name; self.class.name.split( "::" ).last; end
      def packages; [class_name.downcase].to_json end
      
      def value_for( method_or_proc, obj )
        method_or_proc.is_a?( Proc ) ? method_or_proc.call( obj ) : obj.send( method_or_proc )
      end

      # stub
      def setup_data; end

      # === columns and rows
      def columns 
        @columns.join( "\n" )
      end

      def add_column( type, value )
        @columns << "data.addColumn( '#{type}', '#{value}' );"
      end
      
      def rows 
        [
          "data.addRows([ ",
          @rows.join( ", \n" ),
          "]);"
        ].join( "\n" )
      end

      def add_row( value )
        @rows << value.to_json
      end


      private

      def google_jsapi
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

            #{columns}
            #{rows}

            var chart = new google.visualization.#{class_name}( document.getElementById('#{@html_options[:id]}') );
            chart.draw( data, #{@options.to_json} );
          });
          EOS
        )
      end

      def container_div
        @template.content_tag( :div, "", :id => @html_options[:id] )
      end

    end

  end
end

# get all the charts
[ :pie, :line, :area, :bar, :column ].each { |chart| require File.dirname( __FILE__ ) + "/charts/#{chart}" }


