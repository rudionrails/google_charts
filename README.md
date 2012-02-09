GoogleCharts is a ruby wrapper to the Google Chart API (http://code.google.com/apis/charttools/)

## Summary

For now, the plugin supports the following charts:
- pie chart
- line chart
- bar chart
- column chart
- area chart

Basically, you can give the chart all the options you would give a GoogleChart when using the Google library: height, width, title, and so on...

For a detailed description of which options to use visit the Google Visualization API and check out the charts there: http://code.google.com/apis/visualization/documentation/gallery.html


## Installation

System wide:

```console
gem install google_charts
```

Or in your Gemfile:

```ruby
gem 'google_charts'
```


## Usage

GoogleCharts is based on a collection of elements. Usually they are records from the database, but can also just be an array.

The following **Stock** class is a Mongoid document and used to keep track of how much we have of any product in our online store. All we need is the product's name and the amount. For simplicity, we'll skip any default values or validations.

```ruby
class Stock
  include Mongoid::Document

  field :name,    type: String
  field :amount,  type: Integer
end
```

Now, let's supply some data for our store.

```ruby
Stock.create name: "Apple",  amount: 10
Stock.create name: "Pear",   amount: 5
Stock.create name: "Banana", amount: 1
```

### Example: Pie chart

In order to figure out how much we have of any product, all we need to do is:

```erb
<%= pie_chart Stock.all do |c| %>
  <% c.title "Total Stock" %>

  <% c.label "Name",    :name %>
  <% c.value "Amount",  :amount %>
<% end %>
```

### Example: Pie chart with block parameters for label and value

In order to dynamically display labels or values within a chart, you may also pass a block:

```erb
<%= pie_chart Stock.all do |c| %>
  <% c.title "Total Stock" %>

  <% c.label("Name")        { |s| "#{s.name} (percent)" } %>
  <% c.value("Percentage")  { |s| s.amount / Stock.sum(:amount) * 100 } %>
<% end %>

```
NOTE: I know that Stock.sum(:amount) is not good practice, but it serves the example.


Copyright &copy; 2010 - 2012 Rudolf Schmidt, released under the MIT license.
