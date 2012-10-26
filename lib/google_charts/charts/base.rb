module GoogleCharts::Charts

  class Base

    @@number = 0

    def initialize( template, collection, options = {} )
      @template = template
      @collection = collection

      @options = options
      @html_options = { :id => "googleChart_#{@@number}" }.merge( options.delete(:html) || {} )
      @@number += 1
      @columns, @rows = [], []
    end
    
    def title( val ); @options[:title] = val; end

    def to_html
      setup_data

      [
        google_jsapi,
        container_div,
        google_chart
      ].join("\n").html_safe
    end


    private

    def packages; ['corechart'].to_json end

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

    def google_jsapi
      @template.javascript_tag(
        <<-EOS
        // if( typeof google == 'undefined' ) {
          document.write(unescape("%3Cscript src='http://www.google.com/jsapi' type='text/javascript'%3E%3C/script%3E"));
        // };
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

          var chart = new google.visualization.#{google_visualization_class}( document.getElementById('#{@html_options[:id]}') );
          chart.draw( data, #{@options.to_json} );
        });
        EOS
      )
    end

    def google_visualization_class
      self.class.name.split( "::" ).last + 'Chart'
    end

    def container_div
      @template.content_tag( :div, "", :id => @html_options[:id] )
    end

  end

end
