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

## Available methods
### Object#deactivate!
Deactivate a single object. This will simply set the activator field to false.

### Object#deactivate_others
This will deactivate all the other objects if the current object is marked as
active. It will exclude itself from the list of records to deactivate.

### Object.active
Get the current active object. This will only fetch one result as you should
only have one active object at a time.
