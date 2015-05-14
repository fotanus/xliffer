module XLIFFer
  class XLIFF
    class String
      attr_reader :id, :source, :target, :note
      def initialize(xml)
        unless xml_element?(xml) and trans_unit?(xml)
          raise ArgumentError, "can't create a String without a trans-unit subtree"
        end

        @id = xml.attr('id')
        @source = get_source(xml)
        @target = get_target(xml)
        @note   = get_note(xml)
      end

      private
      # TODO: move to public method on XLIFF
      def xml_element?(xml)
        xml.kind_of? Nokogiri::XML::Element
      end

      def trans_unit?(xml)
        xml.name.downcase == "trans-unit"
      end

      def get_source(xml)
        sources = xml.xpath("./source")
        raise MultipleElement, "Should have only one source tag" if sources.size > 1
        raise NoElement, "Should have one source tag" unless sources.size == 1
        sources.first.text
      end

      def get_target(xml)
        targets = xml.xpath("./target")
        raise MultipleElement, "Should have only one target tag" if targets.size > 1
        targets.first ? targets.first.text : ''
      end

      def get_note(xml)
        notes = xml.xpath("./note")
        raise MultipleElement, "Should have only one target tag" if notes.size > 1
        notes.first ? notes.first.text : ''
      end
    end
  end
end
