module ODRL::Rights::Constraint
     class Recontext < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
       end
     end
end
