module GoogleCharts::Helpers

  module ActionView

    def self.define_helper( name, options = {} )
      helper_name = [options[:prefix], name, options[:suffix]||'chart'].compact.join( '_' )

      module_eval <<-DEF
        def #{helper_name}( *options )
          chart = GoogleCharts::Charts::#{name.to_s.capitalize}.new( self, *options )
          yield chart if block_given?

          concat chart.to_html
        end
      DEF
    end

    define_helper :line
    define_helper :pie
    define_helper :area
    define_helper :bar
    define_helper :column
    
  end

end