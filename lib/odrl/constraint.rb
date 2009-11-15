module ODRL::Rights::Constraint
     class Base
     	attr_accessor :name

	def self.factory c
           ODRL::Rights::Constraint.const_get(c.name.capitalize).new(c)
	end

	def initialize c
           @name = c.name
	   @xml = c
	   @constraint = []

	   @context = ODRL::Rights::Context.from_xml @xml.xpath('o-dd:context')

	   c.xpath('o-ex:constraint/*', 'o-ex' => 'http://odrl.net/1.1/ODRL-EX').each do |c1|
              constraint = Base.factory(c1, c)
              @constraint << constraint
           end     
	end

	def eval(party = nil, context = nil)
           true
	end
        
	def eval_constraints party, context
           @constraint.each do |c|
                return false if !(c.eval(party, context))
           end
           true
        end
     end
end

require File.dirname(__FILE__) + "/constraint/count"
require File.dirname(__FILE__) + "/constraint/datetime"
require File.dirname(__FILE__) + "/constraint/group"
require File.dirname(__FILE__) + "/constraint/individual"
require File.dirname(__FILE__) + "/constraint/industry"
require File.dirname(__FILE__) + "/constraint/purpose"
require File.dirname(__FILE__) + "/constraint/range"
require File.dirname(__FILE__) + "/constraint/recontext"
require File.dirname(__FILE__) + "/constraint/unit"
