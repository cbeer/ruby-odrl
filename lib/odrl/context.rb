module ODRL::Rights
   class Context
      
      #from ODRL spec

      @uid
      @name
      @role
      @remark

      @event
      @date
      @physical_location
      @digital_location

      @external
      @transaction
      @service
      @version

      @purpose
      @industry

      def self.from_xml c
        return Context.new
      end
      def has c
         !c.nil?
      end
   end
end
