module ODRL::Rights::Constraint
     class Group < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
	 if party.responds_to? 'to_context'
           party.to_context.groups.each do |g|
              return true if @context.has g
	   end
	 elsif party.responds_to? 'groups'
           party.groups.each do |g|
              return true if @context.has g
	   end
	 else
	   false
	 end

       end
     end
end
