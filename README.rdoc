# Activator

Ever needed to mark a record as `active` in your application while all the other
records are `inactive`? Activator is the gem you need.

# How to use?
## Setup

Simply say which field in your model is the `Activator` field, the gem will do
the rest.

```ruby
class Object < ActiveRecord::Base
  activator :active
end
```

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
