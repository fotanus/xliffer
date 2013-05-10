require 'nokogiri'

module XLIFFer
  class XLIFFFile
    attr_reader :version
    def initialize(xliff = nil)
      @files = []
      text = case xliff
             when IO then xliff.read
             when String then xliff
             else fail ArgumentError, "Expects an IO or String"
             end

      parse(text)
    end

    private
    def parse(text)
      begin
        xml = Nokogiri::XML(text)
      rescue => e
        fail FormatError, "Not a XML file"
      end

      root = xml.xpath('/xliff')
      raise FormatError, "Not a XLIFF file" unless root.any?

      @version = get_version(xml)
    end

    def get_version(xml)
      version_attr = xml.xpath('/xliff/@version').first
      version_attr ? version_attr.value : nil
    end
  end
end
