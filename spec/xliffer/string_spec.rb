require 'spec_helper'
require 'nokogiri'

module XLIFFer
  describe XLIFF::String do
    context "#new" do
      before(:all) do
        @minimal_trans_unit = <<-EOF
        <trans-unit id="my id">
          <source>Hello World</source>
          <target>Bonjour le monde</target>
        </trans-unit>
        EOF
      end
      it "is created with a nokogiri trans-unit node" do
        trans_unit_node = Nokogiri::XML.parse(@minimal_trans_unit).xpath("//trans-unit").first
        expect(XLIFF::String.new(trans_unit_node)).to be
      end

      it "can't be created with a string" do
        expect{XLIFF::String.new("<file></file>")}.to raise_error ArgumentError
      end

      it "can't be created with a node that is not a file node" do
        trans_unit_node = Nokogiri::XML.parse("<xliff></xliff>").xpath("/xliff").first
        expect{XLIFF::String.new(trans_unit_node)}.to raise_error ArgumentError
      end

      it "have one source" do
        xml = "<trans-unit><target></target></trans-unit>"
        trans_unit_node = Nokogiri::XML.parse(xml).xpath("//trans-unit").first
        expect{XLIFF::String.new(trans_unit_node)}.to raise_error NoElement
      end

      it "don't have multiple sources tag" do
        xml = "<trans-unit>#{"<source></source>"*2}<target></target></trans-unit>"
        trans_unit_node = Nokogiri::XML.parse(xml).xpath("//trans-unit").first
        expect{XLIFF::String.new(trans_unit_node)}.to raise_error MultipleElement
      end

      it "don't have multiple targets tag" do
        xml = "<trans-unit><source></source>#{"<target></target>"*2}</trans-unit>"
        trans_unit_node = Nokogiri::XML.parse(xml).xpath("//trans-unit").first
        expect{XLIFF::String.new(trans_unit_node)}.to raise_error MultipleElement
      end
    end

    context "#id" do
      it "is nil if not defined" do
        xml = "<trans-unit><source></source><target></target></trans-unit>"
        trans_unit_node = Nokogiri::XML.parse(xml).xpath("//trans-unit").first
        expect(XLIFF::String.new(trans_unit_node).id).to be nil
      end

      it "is the id attribute on trans-unit tag" do
        xml = "<trans-unit id='my id'><source></source><target></target></trans-unit>"
        trans_unit_node = Nokogiri::XML.parse(xml).xpath("//trans-unit").first
        expect(XLIFF::String.new(trans_unit_node).id).to eql("my id")
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

      it 'Modify target' do
        trans_unit_node = Nokogiri::XML.parse(@trans_unit).xpath("//trans-unit").first
        string = XLIFF::String.new(trans_unit_node)
        string.target = 'Hola Mundo'
        expect(string.target).to eq 'Hola Mundo'
      end

      it 'Modify target if xml doensnt contain target initially' do
        xml = "<trans-unit id='my id'><source>Value</source></trans-unit>"
        trans_unit_node = Nokogiri::XML.parse(xml).xpath("//trans-unit").first
        string = XLIFF::String.new(trans_unit_node)
        string.target = 'Hola Mundo'
        expect(string.target).to eq 'Hola Mundo'
      end
    #  it "is an array " do
    #    trans_unit_node = Nokogiri::XML.parse("<xliff><file></file></xliff>").xpath("//file").first
    #    XLIFF::File.new(trans_unit_node).strings.should be_kind_of(Array)
    #  end

    #  it "can be empty" do
    #    trans_unit_node = Nokogiri::XML.parse("<xliff><file></file></xliff>").xpath("//file").first
    #    XLIFF::File.new(trans_unit_node).strings.should be_empty
    #  end

    #  it "should have a string" do
    #    trans_unit_node = Nokogiri::XML.parse("<xliff><file>#{@trans_unit}</file></xliff>").xpath("//file").first
    #    XLIFF::File.new(trans_unit_node).strings.size.should eql(1)
    #  end

    #  it "should have multiple strings" do
    #    trans_unit_node = Nokogiri::XML.parse("<xliff><file>#{@trans_unit * 10}</file></xliff>").xpath("//file").first
    #    XLIFF::File.new(trans_unit_node).strings.size.should eql(10)
    #  end
    end
  end
end
