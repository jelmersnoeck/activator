# Activator

Ever needed to mark a record as `active` in your application while all the other
records are `inactive`? Activator is the gem you need.

# How to use?
## Setup

For now, the gem only works with one field, namely `active`. To use the gem,
simply let an object `act_as_activator`.

```ruby
class Object < ActiveRecord::Base
  act_as_activator
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
