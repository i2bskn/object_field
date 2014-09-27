# ObjectField

[![Gem Version](https://badge.fury.io/rb/object_field.svg)](http://badge.fury.io/rb/object_field)
[![Build Status](https://travis-ci.org/i2bskn/object_field.svg)](https://travis-ci.org/i2bskn/object_field)
[![Coverage Status](https://coveralls.io/repos/i2bskn/object_field/badge.png)](https://coveralls.io/r/i2bskn/object_field)
[![Code Climate](https://codeclimate.com/github/i2bskn/object_field/badges/gpa.svg)](https://codeclimate.com/github/i2bskn/object_field)
[![Dependency Status](https://gemnasium.com/i2bskn/object_field.svg)](https://gemnasium.com/i2bskn/object_field)

Support for object persistence.  
Save the object to data store via instance method.

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

Include `ObjectField::Jsonizer` or `ObjectField::Serializer`.

#### Jsonizer

`.#jsonize` defines accessor of JSON field.  

```ruby
class InJsonValue
  include ObjectField::Jsonizer
  attr_accessor :field1_json, :field2, :field3_json
  jsonize :field1_json, :field2
  jsonize :field3_json, as: :attributes
end
```

Setter is save the value to JSON.  
Getter returns parsed value.  
Name of accessor can be specified with `as` option.  
It is set `field1`, `field2_as_json` if not specified.

```ruby
object = InJsonValue.new
object.field1 = [1, 2, 3]
p object.field1_json # => "[1,2,3]"
object.field1.each {|i| p i}
```

#### Serializer

`.#serialize` defines accessor of marshal data field.  
Like marshal option of [redis-object](https://github.com/nateware/redis-objects).

```ruby
class InSerializedValue
  include ObjectField::Serializer
  attr_accessor :field
  serialize :field
end
```

Setter is save the serialized value.  
Can not be saved, Proc object and anonymous class. (To raise TypeError)  
Getter returns deserialized value.  
Name of accessor can be specified with `as` option.  
It is set `field_data` if not specified.

```
class SerializedObject; end
object = InSerializedValue.new
object.field_data = SerializedObject.new
p object.field_data.class # => SerializedObject
```

## Contributing

1. Fork it ( https://github.com/i2bskn/object_field/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

