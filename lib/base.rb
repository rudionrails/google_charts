module Rudionrails
  module AwesomeChart

    class Base

      def initialize( template, collection, options = {}, html_options = {} )
        @template = template
        @collection = collection
        @options = options
        @html_options = html_options.reverse_merge( :id => "awesomeChart" )

        @html = [include_google_api, container_div]
      end

      def title( val ); @options[:title] = val; end

      # stub
      def to_html
      end

      protected

      def include_google_api
        <<-EOS
        <script type="text/javascript">
          if( typeof google == 'undefined' ) {
            document.write(unescape("%3Cscript src='http://www.google.com/jsapi' type='text/javascript'%3E%3C/script%3E"));
          };
        </script>
        EOS
      end

      def container_div
        <<-EOS
        <div id="#{@html_options[:id]}"></div>
        EOS
      end

    end

  end
end