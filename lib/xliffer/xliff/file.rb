require 'xliffer/xliff'
require 'nokogiri'

module XLIFFer
  class XLIFF
    class File
      attr_reader :source_language, :target_language, :original, :strings
      alias_method :file_name, :original
      def initialize(xml)
        unless XLIFF::xml_element?(xml) and file?(xml)
          raise ArgumentError, "can't create a File without a file subtree"
        end

        @xml = xml

        @original = @xml.attr("original")
        @source_language = @xml.attr("source-language")
        @target_language = @xml.attr("target-language")
        @strings = @xml.xpath('.//trans-unit').map{|tu| String.new(tu) }
      end

      def [](id)
        @strings.find { |s| s.id == id }
      end

      def []=(id, target)
        self[id].target = target
      end

      def source_language=(val)
        @source_language = val
        @xml['source_language'] = val
      end

      def target_language=(val)
        @target_language = val
        @xml['target_language'] = val
      end
      private

      def file?(xml)
        xml.name.downcase == "file"
      end
    end
  end
end
