# Protector::Cancan

[![Gem Version](https://badge.fury.io/rb/protector-cancan.png)](http://badge.fury.io/rb/protector-cancan)
[![Build Status](https://travis-ci.org/inossidabile/protector-cancan.png?branch=master)](https://travis-ci.org/inossidabile/protector-cancan)
[![Code Climate](https://codeclimate.com/github/inossidabile/protector-cancan.png)](https://codeclimate.com/github/inossidabile/protector-cancan)

Integrates [Protector](https://github.com/inossidabile/protector) and [CanCan](https://github.com/ryanb/cancan).

Protector and CanCan are all about the same thing: access control. They however act on different fronts: Protector works on a model level and CanCan is all about controllers defense. With this gem you don't have to choose anymore: make them work together for the best result.

The integration makes CanCan aware of Protector restrictions. You still can have separate `Ability` instance and even extend (or override) what comes from Protector.

Additionally CanCan will automatically restrict instances with `current_user` during `load_resource` part.

## Installation

You are expected to have generated CanCan ability by this moment. Proceed to [CanCan installation tutorial](https://github.com/ryanb/cancan#1-define-abilities) to make one if you don't.

Add this line to your application's Gemfile:

    gem 'protector-cancan'

And then execute:

    $ bundle

Now modify your `Ability` definition in the following way:

```ruby
class Ability
  include CanCan::Ability

  def intialize(user)
    import_protector user # <- add this
  end
end
```

## Example

For the case when you have the following model defined:

```ruby
class Dummy < ActiveRecord::Base
  protect do |user|
    can :read if user
  end
end
```

If you call `can? :view, Dummy`, the gem will evaluate `Dummy` protection block against value passed to `import_protector` (by default it's `current_user`) and expand CanCan rules with resulting meta. Note that gem automatically converts `:read` to `:view` so you should use CanCan naming conventions when working with CanCan.

So in this particular case we will get `true` if `current_user` is set and `false` otherwise.

And that's how controller is going to work:

```ruby
class DummiesController
  load_and_authorize_resources

  def index    # Will be accessible if current_user isn't blank
    @dummies   # => Dummy.restrict!(current_user)
  end

  def show     # Will be accessible if current_user isn't blank
    @dummy     # => Dummy.find(params[:id]).restrict!(current_user)
  end
end
```

## Maintainers

* Boris Staal, [@inossidabile](http://staal.io)

## License

It is free software, and may be redistributed under the terms of MIT license.