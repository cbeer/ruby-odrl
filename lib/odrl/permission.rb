module ODRL::Rights
   class Permission
      attr_accessor :type
      def initialize p
         @type = p.name
	 @requirement = []
	 @constraint = []

	 p.xpath('o-ex:requirement/*', 'o-ex' => 'http://odrl.net/1.1/ODRL-EX').each do |r|
           requirement = Requirement::Base.factory r
           @requirement << requirement
         end
         p.xpath('o-ex:constraint/*', 'o-ex' => 'http://odrl.net/1.1/ODRL-EX').each do |c|
           constraint = Constraint::Base.factory c
           @constraint << constraint
         end
      end

      def eval(party, context)
         return true if @requirement.empty? and @constraint.empty?
         @requirement.each do |r|
            return false if !(r.eval(party, context))
	 end
	 @constraint.each do |c|
            return false if !(c.eval(party, context))
	 end

	 true
      end
   end
end
