module Archdown
  # The Library knows about its locations for books (e.g. file directory)
  class Library
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def first(identifier)
      identifier[0..1].downcase
    end

    def last(identifier)
      identifier[-2..-1].downcase
    end

    def path_for_identifier(identifier, *parts)
      File.join(path, first(identifier), last(identifier), identifier, *parts)
    end
  end
end