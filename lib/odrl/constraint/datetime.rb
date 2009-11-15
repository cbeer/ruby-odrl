module ODRL::Rights::Constraint
     class DateTime < Base
       def eval(party = nil, context = nil)
         return false if !eval_constraints(party, context)
	 r_start = strptime(@xml.xpath('//o-dd:start').content)
	 r_end = strptime(@xml.xpath('//o-dd:end').content)
	 r_now = DateTime.new # from context?
	 r_now <= r_start and r_now <= r_end
       end
     end
end
