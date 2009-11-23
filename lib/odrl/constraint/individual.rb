module ODRL::Rights::Constraint
     class Individual < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
	 @context.has party
       end
     end
end
