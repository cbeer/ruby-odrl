module ODRL::Rights::Constraint
     class Unit < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
       end
     end
end
