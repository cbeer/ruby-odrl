module ODRL::Rights
   class Context
      
      #from ODRL spec
		@context
#      @uid
#      @name
#      @role
#      @remark

#      @event
#      @date
#      @physical_location
#      @digital_location

#      @external
#      @transaction
#      @service
#      @version

#      @purpose
#      @industry
      
	  def initialize c
	  	@context = c
	  end
	  
      def self.from_xml c
        return Context.new c
      end
      
      def has o
      	return false if o.nil?
      	@context.xpath('o-dd:*', 'o-dd' => 'http://odrl.net/1.1/ODRL-DD').each do |c|
		next if c.name == 'name' && o == c.text
      		return false unless o.respond_to?(c.name)
      		v = o.send(c.name)
      		if v.respond_to? 'any?'
			return false unless v.any? { |e| e == c.text || e =~ Regexp.new(c.text) }
      		else
      			return false unless v == c.text || v =~ Regexp.new(c.text)
      		end
      	end
      	true
      end
      
   end
end
