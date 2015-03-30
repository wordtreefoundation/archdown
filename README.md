# Archdown

Command-line utility to download books from archive.org using [archivist-client](https://github.com/wordtreefoundation/archivist-client)

| Project                 |  Archdown         |
|------------------------ | ----------------- |
| gem name                |  archdown         |
| license                 |  MIT              |
| moldiness               |  [![Maintainer Status](http://stillmaintained.com/wordtreefoundation/archdown.png)](http://stillmaintained.com/wordtreefoundation/archdown) |
| version                 |  [![Gem Version](https://badge.fury.io/rb/archdown.png)](http://badge.fury.io/rb/archdown) |
| dependencies            |  [![Dependency Status](https://gemnasium.com/wordtreefoundation/archdown.png)](https://gemnasium.com/wordtreefoundation/archdown) |
| code quality            |  [![Code Climate](https://codeclimate.com/github/wordtreefoundation/archdown.png)](https://codeclimate.com/github/wordtreefoundation/archdown) |
| inline documenation     |  [![Inline docs](http://inch-ci.org/github/wordtreefoundation/archdown.png)](http://inch-ci.org/github/wordtreefoundation/archdown) |
| continuous integration  |  [![Build Status](https://secure.travis-ci.org/wordtreefoundation/archdown.png?branch=master)](https://travis-ci.org/wordtreefoundation/archdown) |
| test coverage           |  [![Coverage Status](https://coveralls.io/repos/wordtreefoundation/archdown/badge.png)](https://coveralls.io/r/wordtreefoundation/archdown) |
| homepage                |  [https://github.com/wordtreefoundation/archdown][homepage] |
| documentation           |  [http://rdoc.info/github/wordtreefoundation/archdown/frames][documentation] |
| authors                 |  [Duane Johnson](https://coderbits.com/canadaduane) [![Endorse Duane](https://api.coderwall.com/canadaduane/endorsecount.png)](http://coderwall.com/canadaduane) |
|                         |  [Peter Boling](https://coderbits.com/pboling) [![Endorse Peter](https://api.coderwall.com/pboling/endorsecount.png)](http://coderwall.com/pboling) |


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'archdown'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install archdown

## Usage

Download from the command-line:

```sh
$ gem install archdown
$ archdown -y 1700-1830

# ...
# downloads a lot of books into ./library
# ...
```

More advanced usage: use as a Ruby library. Here's an example of a query that downloads a book by archive.org identifier:

```ruby
d = Archdown::Download.new('library',
  :filters => ["identifier:firstbooknapole00gruagoog"])

d.go!{ |metadata, librarian| puts m.inspect }
```

Or a set of books within a range of years:

```ruby
d = Archdown::Download.new('library',
  :start_year => 1800, :end_year => 1850)

d.go!{ |metadata, librarian| puts m.inspect }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/archdown/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Make sure to add tests!
5. Create a new Pull Request

## Contributors

See the [Network View](https://github.com/wordtreefoundation/archdown/network)

## References

* [Source Code](http://github.com/wordtreefoundation/archivist-client)
* [Blog](http://blog.wordtree.org/2015/03/29/using-textgrams-jl/)

[semver]: http://semver.org/
[pvc]: http://docs.rubygems.org/read/chapter/16#page74
[documentation]: http://rdoc.info/github/wordtreefoundation/archdown/frames
[homepage]: https://github.com/wordtreefoundation/archdown