module ODRL::Rights
   class Document
      attr_accessor :doc, :offer

      def initialize
         @offer = []
      end

      def doc= doc
         @doc = Nokogiri::XML doc
	 @doc.xpath('//o-ex:offer', 'o-ex' => 'http://odrl.net/1.1/ODRL-EX').each do |o|
            offer = Offer.new o
	    @offer << offer
	 end
      end

      def eval(permission, asset, party, context)
         @offer.each do |o|
	   return true if o.eval permission, asset, party, context
	 end
	 false
      end
      
      def to_xml
      
      end
   end
end
