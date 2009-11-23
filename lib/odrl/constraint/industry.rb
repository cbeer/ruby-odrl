module ODRL::Rights::Constraint
     class Industry < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
	 party.has_industry @xml['type']
       end
     end
end
