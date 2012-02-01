module GoogleCharts::Charts

  class Pie < GoogleCharts::Charts::Base
    def initialize( template, collection, options = {} )
      super

      @label, @value = [], []
    end

    def label(name, method = nil, &block); @label = [name, block ? block : method]; end
    def value(name, method = nil, &block); @value = [name, block ? block : method]; end


    private

    def setup_data
      # setup the columns
      add_column( 'string', @label.first )
      add_column( 'number', @value.first )

      # setup the rows
      @collection.each do |col|
        add_row( [value_for(@label.last, col), value_for(@value.last, col)] )
      end
    end
  end

end
