# ObjectField

[![Gem Version](https://badge.fury.io/rb/object_field.svg)](http://badge.fury.io/rb/object_field)
[![Build Status](https://travis-ci.org/i2bskn/object_field.svg)](https://travis-ci.org/i2bskn/object_field)
[![Coverage Status](https://coveralls.io/repos/i2bskn/object_field/badge.png)](https://coveralls.io/r/i2bskn/object_field)
[![Code Climate](https://codeclimate.com/github/i2bskn/object_field/badges/gpa.svg)](https://codeclimate.com/github/i2bskn/object_field)
[![Dependency Status](https://gemnasium.com/i2bskn/object_field.svg)](https://gemnasium.com/i2bskn/object_field)

Support for object persistence.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'object_field'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install object_field

## Usage

```ruby
require "object_field"

class Example
  include ObjectField::Jsonizer
  attr_accessor :field1_json, :field2_json, :field3_json
  jsonize :field1_json, :field2_json
  jsonize :field3_json, as: :attributes
end

e = Example.new
e.field1 = [1, 2, 3]
e.attributes = {key: :value}
p e # => #<Example:0x007fa5914ac548 @field1_json="[1,2,3]", @field3_json="{\":key\":\":value\"}">
puts e.attributes[:key] # => value
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/object_field/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
