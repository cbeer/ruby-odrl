module ODRL::Rights::Constraint
     class Purpose < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
	 party.has_purpose @xml['type']
       end
     end
end
