require 'spec_helper'

module XLIFFer
  describe XLIFF do
    context "#new" do
      it "accepts a xliff file" do
        XLIFF.new(::File.open("spec/files/empty.xliff")).should be
      end

      it "accepts a xliff string" do
        XLIFF.new(::File.open("spec/files/empty.xliff").read).should be
      end

      it "doesn't accept a number" do
        expect{XLIFF.new(123)}.to raise_error ArgumentError
      end

      it "doesn't accept a random string" do
        expect{XLIFF.new("foobar")}.to raise_error FormatError
      end

      it "doesn't accept a random file" do
        expect{XLIFF.new(::File.new("spec/files/file.foobar"))}.to raise_error FormatError
      end
    end

    context "#version" do
      it "is the xliff version" do
        XLIFF.new('<xliff version="9.8"></xliff>').version.should eql("9.8")
      end

      it "is nil when it is not present" do
        XLIFF.new('<xliff></xliff>').version.should be_nil
      end

      it "is a string when there is a xliff version" do
        XLIFF.new('<xliff version="9.8"></xliff>').version.should be_kind_of(String)
      end
    end

    context "#files" do
      it "is an array " do
        XLIFF.new('<xliff></xliff>').files.should be_kind_of(Array)
      end

      it "can be empty" do
        XLIFF.new('<xliff></xliff>').files.should be_empty
      end

      it "should have a file" do
        XLIFF.new('<xliff><file></file></xliff>').files.first.should be_kind_of(XLIFF::File)
      end

      it "should have multiple files" do
        XLIFF.new('<xliff><file></file><file></file></xliff>').files.size.should eql(2)
      end
    end
  end
end
