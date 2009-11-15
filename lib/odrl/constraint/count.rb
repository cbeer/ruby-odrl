module ODRL::Rights::Constraint
     class Count < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
	 $session[@id]=0 if $session[@id].nil?
	 $session[@id] += 1
	 $session[@id] <= @xml.content.to_i
       end
     end
end
