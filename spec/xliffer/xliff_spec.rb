require 'spec_helper'

module XLIFFer
  describe XLIFF do
    context "#new" do
      it "accepts a xliff file" do
        expect(XLIFF.new(::File.open("spec/files/empty.xliff"))).to be
      end

      it "accepts a xliff string" do
        expect(XLIFF.new(::File.open("spec/files/empty.xliff").read)).to be
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
        expect(XLIFF.new('<xliff version="9.8"></xliff>').version).to eql("9.8")
      end

      it "is nil when it is not present" do
        expect(XLIFF.new('<xliff></xliff>').version).to be_nil
      end

      it "is a string when there is a xliff version" do
        expect(XLIFF.new('<xliff version="9.8"></xliff>').version).to be_kind_of(String)
      end
    end

    context "#files" do
      it "is an array " do
        expect(XLIFF.new('<xliff></xliff>').files).to be_kind_of(Array)
      end

      it "can be empty" do
        expect(XLIFF.new('<xliff></xliff>').files).to be_empty
      end

      it "should have a file" do
        expect(XLIFF.new('<xliff><file></file></xliff>').files.first).to be_kind_of(XLIFF::File)
      end

      it "should have multiple files" do
        expect(XLIFF.new('<xliff><file></file><file></file></xliff>').files.size).to eql(2)
      end
    end

    context "#regenate" do
      it 'should output an xml' do
        xml = ::File.open("spec/files/empty.xliff").read
        xliff = XLIFF.new(xml)
        expect(xliff.to_s).to be_equivalent_to(xml)
      end
    end
  end
end
