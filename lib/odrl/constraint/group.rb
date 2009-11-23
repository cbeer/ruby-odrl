module ODRL::Rights::Constraint
     class Group < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
         party.groups.each do |g|
            return true if @context.has g
	 end
	 false
       end
     end
end
