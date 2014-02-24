require 'fileutils'
require 'yaml'
require 'archivist/client'
require 'optparse'

# The Library knows about its locations for books (e.g. file directory)
class Library
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def first(identifier)
    identifier[0..1]
  end

  def last(identifier)
    identifier[-2..-1]
  end

  def path_for_identifier(identifier, *parts)
    File.join(path, first(identifier), last(identifier), identifier, *parts)
  end
end

# The Librarian takes a book and puts it in the library
class Librarian
  attr_reader :library, :book

  def initialize(library, book)
    @library = library
    @book = book
    @failure = nil
  end

  def metadata
    {
      'title'  => @book.title,
      'author' => @book.creators ? @book.creators.join(';') : nil,
      'year'   => @book.date.year,
      'source' => "http://archive.org/details/#{@book.identifier}",
      'status' => "OCR ONLY",
      'archive_org_id' => @book.identifier,
    }.tap do |meta|
      meta['failure'] = @failure if @failure
    end
  end

  def book_dir
    @library.path_for_identifier(@book.identifier)
  end

  def book_filepath
    File.join(book_dir, @book.identifier + '.md')
  end

  def make_book_dir
    FileUtils.mkdir_p(book_dir)
  end

  def store_book
    make_book_dir

    begin
      text = @book.download
    rescue Archivist::Model::Document::UnsupportedFormat => e
      @failure = e.to_s
    rescue StandardError => e
      @failure = e.to_s
    end

    puts metadata.to_yaml

    content = metadata.to_yaml
    content += "---\n"
    content += text if text

    File.open(book_filepath, "w") do |file|
      file.write content
    end
  end
end

class Download
  attr_reader :library_root, :search_terms

  def initialize(library_root, search_terms)
    @library = Library.new(library_root)
    @search_terms = search_terms
    @client = Archivist::Client::Base.new
  end

  def go!
    page = 1
    while not (books = @client.search(@search_terms.merge(:page => page))).empty?
      books.each do |book|
        Librarian.new(@library, book).store_book
      end
      page += 1
    end
  end
end

# download books (text files) from archive.org

options = {
  :library_root => File.join(File.dirname(__FILE__), 'library'),
  :start_year => 1700,
  :end_year   => 1700
}
parser = OptionParser.new do |opts|
  opts.banner = "Usage: archdown.rb [options]"

  opts.on("-l", "--library PATH", "Store files in PATH") do |lib|
    options[:library_root] = lib
  end

  opts.on("-y", "--year RANGE", "Query for books published within RANGE years, e.g. 1700-1750") do |range|
    options[:start_year] = range.split('-').first.to_i
    options[:end_year] = range.split('-').last.to_i
  end
end
parser.parse!

if ARGV.empty?
  download = Download.new(
    options[:library_root],
    :start_year => options[:start_year],
    :end_year   => options[:end_year])
  download.go!
else
  puts parser
  puts
  p options, ARGV
end



