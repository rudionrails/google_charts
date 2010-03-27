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
      
      # stub to be integrated by each chart subclass
      def google_chart
      end
      
      def container_div
        @template.content_tag(:div, "", :id => @html_options[:id])
      end

    end

  end
end
