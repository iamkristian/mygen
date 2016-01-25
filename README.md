# Mygen

A code generator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mygen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mygen

## Usage

Mygen will help you create repetitious code and folder structures. It works
through plugins, that you create through mygen. Get a full list of options and
commands with

```
myg --help
```

### Making a new plugin

Create your first plugin like this

```
myg g myg my_plugin
```

This will create a plugin called ``` my_plugin ```. You will need to run the
bundle command to install dependencies.

In order for mygen to find the plugin, you can make a symlink into

``` ~./.mygen/plugins/my_plugin ```

or you can commit your plugin to github and clone it into you plugins folder.

This will enable mygen to autodetect new plugins.


#### Substitution of filenames

Files named with ``` name ``` will be renamed to match the attribute  ``` name ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iamkristian/mygen.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

