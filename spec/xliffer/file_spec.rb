require 'spec_helper'
require 'nokogiri'

module XLIFFer
  describe XLIFF::File do
    context "#new" do
      it "is created with a nokogiri file node" do
        file_node = Nokogiri::XML.parse("<file></file>").xpath("/file").first
        XLIFF::File.new(file_node).should be
      end

      it "can't be created with a string" do
        expect{XLIFF::File.new("<file></file>")}.to raise_error ArgumentError
      end

      it "can't be created with a node that is not a file node" do
        file_node = Nokogiri::XML.parse("<xliff><file></file></xliff>").xpath("/xliff").first
        expect{XLIFF::File.new(file_node)}.to raise_error ArgumentError
      end
    end

    context "#original" do
      it "is nil if not defined" do
        file_node = Nokogiri::XML.parse("<xliff><file></file></xliff>").xpath("//file").first
        XLIFF::File.new(file_node).original.should be nil
      end

      it "is the original attribute on file tag" do
        file_node = Nokogiri::XML.parse('<xliff><file original="neat file.c"></file></xliff>').xpath("//file").first
        XLIFF::File.new(file_node).original.should eql("neat file.c")
      end
    end

    context "#original" do
      it "is nil if not defined" do
        file_node = Nokogiri::XML.parse("<xliff><file></file></xliff>").xpath("//file").first
        XLIFF::File.new(file_node).original.should be nil
      end

      it "is the original attribute on file tag" do
        file_node = Nokogiri::XML.parse('<xliff><file original="neat file.c"></file></xliff>').xpath("//file").first
        XLIFF::File.new(file_node).original.should eql("neat file.c")
      end
    end

    context "#source_language" do
      it "is nil if not defined" do
        file_node = Nokogiri::XML.parse("<xliff><file></file></xliff>").xpath("//file").first
        XLIFF::File.new(file_node).source_language.should be nil
      end

      it "is the original attribute on file tag" do
        file_node = Nokogiri::XML.parse('<xliff><file source-language="en"></file></xliff>').xpath("//file").first
        XLIFF::File.new(file_node).source_language.should eql("en")
      end
    end

    context "#target_language" do
      it "is nil if not defined" do
        file_node = Nokogiri::XML.parse("<xliff><file></file></xliff>").xpath("//file").first
        XLIFF::File.new(file_node).target_language.should be nil
      end

      it "is the original attribute on file tag" do
        file_node = Nokogiri::XML.parse('<xliff><file target-language="fr"></file></xliff>').xpath("//file").first
        XLIFF::File.new(file_node).target_language.should eql("fr")
      end
    end

    context "#strings" do
      before(:all) do
        @trans_unit = <<-EOF
        <trans-unit id="my id">
          <source>Hello World</source>
          <target>Bonjour le monde</target>
        </trans-unit>
        EOF
      end
      it "is an array " do
        file_node = Nokogiri::XML.parse("<xliff><file></file></xliff>").xpath("//file").first
        XLIFF::File.new(file_node).strings.should be_kind_of(Array)
      end

      it "can be empty" do
        file_node = Nokogiri::XML.parse("<xliff><file></file></xliff>").xpath("//file").first
        XLIFF::File.new(file_node).strings.should be_empty
      end

      it "should have a string" do
        file_node = Nokogiri::XML.parse("<xliff><file>#{@trans_unit}</file></xliff>").xpath("//file").first
        XLIFF::File.new(file_node).strings.size.should eql(1)
      end

      it "should have multiple strings" do
        file_node = Nokogiri::XML.parse("<xliff><file>#{@trans_unit * 10}</file></xliff>").xpath("//file").first
        XLIFF::File.new(file_node).strings.size.should eql(10)
      end
    end
  end
end
