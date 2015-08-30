module XLIFFer
  class XLIFF
    class String
      attr_reader :id, :source, :target, :note
      def initialize(trans_unit_xml)
        unless XLIFF.xml_element?(trans_unit_xml) && trans_unit?(trans_unit_xml)
          fail ArgumentError, "can't create a String without a trans-unit subtree"
        end

        @xml = trans_unit_xml
        @id = @xml.attr('id')
        @source = get_source
        @target = get_target
        @note   = get_note
      end

      def target=(val)
        target = @xml.xpath('./target')
        target.first.content = val
        @target = val
      end

      def source=(val)
        source = @xml.xpath('./source')
        source.first.content = val
        @source = val
      end

      private

      def trans_unit?(xml)
        xml.name.downcase == 'trans-unit'
      end

      def get_source
        sources = @xml.xpath('./source')
        fail MultipleElement, 'Should have only one source tag' if sources.size > 1
        fail NoElement, 'Should have one source tag' unless sources.size == 1
        sources.first.text
      end

      def get_target
        targets = @xml.xpath('./target')
        fail MultipleElement, 'Should have only one target tag' if targets.size > 1
        if targets.empty?
          targets << Nokogiri::XML::Node.new('target', @xml)
          @xml.add_child(targets.first)
        end
        targets.first.text
      end

      def get_note
        notes = @xml.xpath('./note')
        fail MultipleElement, 'Should have only one target tag' if notes.size > 1
        notes.first ? notes.first.text : ''
      end
    end
  end
end
