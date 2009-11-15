module ODRL::Rights::Requirement
     class Register < Base
       def eval(party = nil, context = nil)
          !party.nil?
       end
     end
end
