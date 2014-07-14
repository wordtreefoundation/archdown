archdown
========

Command-line utility to download books from archive.org using archivist-client

Example Usage
-------------

Download from the command-line:

```sh
$ gem install archdown
$ ruby archdown -y 1700-1830

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