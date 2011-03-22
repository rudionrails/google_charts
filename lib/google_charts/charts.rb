module GoogleCharts
  module Charts

    autoload :Base,   File.dirname(__FILE__) + "/charts/base"
    autoload :Pie,    File.dirname(__FILE__) + "/charts/pie"
    autoload :Line,   File.dirname(__FILE__) + "/charts/line"
    autoload :Area,   File.dirname(__FILE__) + "/charts/area"
    autoload :Bar,    File.dirname(__FILE__) + "/charts/bar"
    autoload :Column, File.dirname(__FILE__) + "/charts/column"

  end
end