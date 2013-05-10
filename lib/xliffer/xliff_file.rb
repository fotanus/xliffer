require 'nokogiri'

module XLIFFer
  class XLIFFFile
    attr_accessor :sources, :targets
    def initialize(xliff = nil)
      @sources = []
      @targets = []
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
    end
  end
end
