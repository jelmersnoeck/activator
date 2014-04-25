# Activator [![Build Status](https://travis-ci.org/jelmersnoeck/activator.svg?branch=master)](https://travis-ci.org/jelmersnoeck/activator)

Ever needed to mark a record as `active` in your application while all the other
records are `inactive`? Activator is the gem you need.

# How to use?
## Setup

For now, the gem only works with one field, namely `active`. To use the gem,
simply include the module `Activator`.

```ruby
class Object < ActiveRecord::Base
  include Activator
end
```

Note that when you don't add this, all the extra methods won't be available.

## Usage

Once you mark one object as active, the others will get deactivated.

```ruby
first = Object.create(:active => true)
first.active # true

second = Object.create(:active => true)
second.active # true
first.active # false

first.update_attributes(:active => true)
first.active # true
second.active #false
```

### Activator field
There's an option to set the field which activator applies to. By default this
will be the `active` field.

To use another field, you can use the `activator_field` option.

```ruby
class Object
  include Activator
  activator_field :default
end
```

This will make `Object.default` available instead of `Object.active` to get your
- in this case - default field.

```ruby
object = Object.create(default: true)
Object.default # object
```

## Available methods
### Object#activator_deactivate!
Deactivate a single object. This will simply set the activator field to false.

### Object.active
Get the current active object. This will only fetch one result as you should
only have one active object at a time.

Note: this method name will change if you use the `activator_field` option.
