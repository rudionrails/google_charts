require File.dirname(__FILE__) + '/lib/google_charts'

if defined?( ActionView::Base )
  ActionView::Base.send :include, Rudionrails::GoogleCharts
else
  $stderr.puts "Skipping GoogleCharts plugin. `gem install actionpack` and try again."
end

