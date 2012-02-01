module GoogleCharts

  autoload :Charts, File.dirname(__FILE__) + "/google_charts/charts"

  module Helpers
    def self.define( name, options = {} )
      helper_name = [options[:prefix], name, options[:suffix]||'chart'].compact.join( '_' )

      module_eval <<-DEF
        def #{helper_name}( *options )
          chart = GoogleCharts::Charts::#{name.to_s.capitalize}.new( self, *options )
          yield chart if block_given?

          chart.to_html
        end
      DEF
    end

    define :line
    define :pie
    define :area
    define :bar
    define :column
  end

end

ActionView::Base.send :include, GoogleCharts::Helpers

