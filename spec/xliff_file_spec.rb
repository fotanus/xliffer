require 'spec_helper'

describe XLIFFer::XLIFFFile do
  context "#new" do
    it "accepts a xliff file" do
      XLIFFer::XLIFFFile.new(File.open("spec/files/empty.xliff")).should be
    end

    it "accepts a xliff string" do
      XLIFFer::XLIFFFile.new(File.open("spec/files/empty.xliff").read).should be
    end

    it "don't accepts a number" do
      expect{XLIFFer::XLIFFFile.new(123)}.to raise_error ArgumentError
    end

    it "don't accepts a random string" do
      expect{XLIFFer::XLIFFFile.new("foobar")}.to raise_error XLIFFer::FormatError
    end

    it "don't accepts a random file" do
      expect{XLIFFer::XLIFFFile.new("file.foobar")}.to raise_error XLIFFer::FormatError
    end
  end

end
