module ODRL::Rights
   class Offer
      attr_accessor :permissions

      def initialize o
         @permissions = []
         o.xpath('//o-ex:permission/*', 'o-ex' => 'http://odrl.net/1.1/ODRL-EX').each do |p|
            perm = Permission.new p
	    @permissions << perm
	 end
      end

      def eval(permission, asset, party, context)
         #todo: check asset
         (@permissions.select { |p| p.type == permission}).each do |p|
            return true if p.eval party, context
	 end
	 false
      end
   end
end
