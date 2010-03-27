require File.dirname(__FILE__) + '/lib/awesome_chart'

if defined?( ActionView::Base )
  ActionView::Base.send :include, Rudionrails::AwesomeChart
else
  $stderr.puts "Skipping AwesomeChart plugin. `gem install actionpack` and try again."
end

