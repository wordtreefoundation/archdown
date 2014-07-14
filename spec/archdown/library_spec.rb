require 'spec_helper'
require 'archdown/library'

describe Archdown::Library do
  let(:library) { Archdown::Library.new("/tmp/library") }

  it "initializes" do
    expect{ library }.to_not raise_error
  end

  it "gets first 2 chars" do
    expect(library.first('happy')).to eq('ha')
  end

  it "gets last 2 chars" do
    expect(library.last('happy')).to eq('py')
  end
end