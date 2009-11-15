module ODRL::Rights::Constraint
     class Purpose < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
	 @xml['type'] == @context.purpose
       end
     end
end
