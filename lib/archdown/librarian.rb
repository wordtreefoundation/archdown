require 'fileutils'
require 'yaml'

require 'archivist/client'

module Archdown
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
        'author' => @book.creator,
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

    def store_book(&block)
      make_book_dir

      begin
        text = @book.download
      rescue Archivist::Model::Document::UnsupportedFormat => e
        @failure = e.to_s
      rescue StandardError => e
        @failure = e.to_s
      end

      yield metadata, self if block_given?

      content = metadata.to_yaml
      content += "---\n"
      content += text if text

      File.open(book_filepath, "w") do |file|
        file.write content
      end
    end
  end
end