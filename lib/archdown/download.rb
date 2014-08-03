require 'archivist/client'
require 'retriable'

require 'archdown/librarian'
require 'archdown/library'

module Archdown
  class Download
    attr_reader :library_root, :search_terms

    def initialize(library_root, search_terms)
      @library = Library.new(library_root)
      @search_terms = search_terms
      @client = Archivist::Client::Base.new
    end

    def go!(&each_book)
      page = 1
      loop do
        books = ::Retriable.retriable :on => Faraday::Error::TimeoutError do
          terms = @search_terms.merge(:page => page)
          begin
            @client.search(terms)
          rescue e
            $stderr.puts "Search Terms: #{JSON.pretty_generate(terms)}"
            raise
          end
        end
  
        break if books.empty?
  
        books.each do |book|
          Librarian.new(@library, book).store_book(&each_book)
        end
        page += 1
      end
    end
  end
end