# DirGlobIgnore

Adds _a-la-git_ features to `Dir::glob` so that file selection will
take in account custom _ignore_ files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dir_glob_ignore'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dir_glob_ignore

## Usage

Once required this gem patches the `Dir` Ruby core class by adding a new method `glob_with_ignore_file`
 which allows to specify _a-la-git_ ignore files.
 
Like with Git, there can be multiple ignore files in sub-directories...

```ruby
require 'dir_glob_ignore'

Dir.glob_with_ignore_file '.my_ignore_file', '/a/root/directory', *standard_glob_options
```

* The first parameter specifies the name (without path) of the ignore files to look for.
* The second parameter specifies a root directory for ignore files. This is not a root directory 
for the glob function but actually defines where to search ignore files.
* Then the remaining parameters are identical to the ones you could pass to `Dir::glob`
 
## Ignore files format

The format is really simple, inspired by `.gitignore` file format:

* You can specify comment lines with "#".
* Blank lines are ignored.
* Patterns are actually any `Dir::glob` valid pattern

## Current limitations and TODOs

### Positive patterns

Currently you can't specify a "_positive_" pattern like in `.gitignore` files (using "!").

PR welcome...

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lbriais/dir_glob_ignore. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

