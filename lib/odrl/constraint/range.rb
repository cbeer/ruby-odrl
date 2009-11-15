module ODRL::Rights::Constraint
     class Range < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
	 v = 0
	 r_begin = @xml.xpath('o-dd:min').contents.to_i
	 r_end = @xml.xpath('o-dd:max').contents.to_i
	 v >= r_begin and v <= r_end
       end
     end
end
