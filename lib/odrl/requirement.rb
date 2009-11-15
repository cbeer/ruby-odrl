module ODRL::Rights::Requirement
     class Base
     	attr_accessor :name

	def self.factory r
           ODRL::Rights::Requirement.const_get(r.name.capitalize).new(r)
	end

	def initialize r
           @name = r.name
	end

	def eval(party = nil, context = nil)
           true
	end
     end
end

require File.dirname(__FILE__) + "/requirement/accept"
require File.dirname(__FILE__) + "/requirement/register"
