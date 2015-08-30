require 'nokogiri'
require 'xliffer/xliff/file'

module XLIFFer
  class XLIFF
    attr_reader :version, :files
    def initialize(xliff = nil)
      text = case xliff
             when ::IO then xliff.read
             when ::String then xliff
             else fail ArgumentError, 'Expects an IO or String'
             end

      parse(text)
    end

    def to_s
      @xml.to_xml
    end

    private

    def parse(text)
      @xml = Nokogiri::XML(text)

      @xml.remove_namespaces!
      root = @xml.xpath('/xliff')
      fail FormatError, 'Not a XLIFF file' unless root.any?

      @version = get_version(root)
      @files = parse_files(root)
    end

    def get_version(root)
      version = root.attr('version')
      version ? version.value : nil
    end

    def parse_files(root)
      root.xpath('//file').map { |f| File.new(f) }
    end

    def self.xml_element?(xml)
      xml.is_a? Nokogiri::XML::Element
    end
  end
end
