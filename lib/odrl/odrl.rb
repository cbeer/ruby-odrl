require 'nokogiri'
require 'uuid'

$uuid = UUID.new
$session = {}

module ODRL
  class Rights
    attr_accessor :doc, :offer
    @doc
    @context
    @offer
    @agreement
    def initialize
      @offer = []
    end
    class Offer
     attr_accessor :permissions
     @permissions
     def initialize o
       @permissions = []
       
       o.xpath('//o-ex:permission/*', 'o-ex' => 'http://odrl.net/1.1/ODRL-EX').each do |p|
         perm = ODRL::Rights::Offer::Permission.new p
         @permissions << perm
       end         
     end
     class Permission
        attr_accessor :type
		@type
		@requirement
		@constraint
		def initialize p
		  @requirement = []
		  @constraint = []
		  @type = p.name
		  p.xpath('o-ex:requirement/*', 'o-ex' => 'http://odrl.net/1.1/ODRL-EX').each do |r|
		    requirement = Requirement.factory r
		    @requirement << requirement
		  end
		  p.xpath('o-ex:constraint/*', 'o-ex' => 'http://odrl.net/1.1/ODRL-EX').each do |c|
		    constraint = Constraint.factory c
		    @constraint << constraint
		  end
		end
        class Requirement
          attr_accessor :name
		  @name
		  
		  def self.factory r
		  	Requirement.const_get(r.name.capitalize).new(r)
		  end
		  
		  def initialize r
		    @name = r.name
		  end
          def eval party, context
            true
		  end
		  
		  class Accept < Requirement
		    def eval party, context
		      #accept in context?
		    end
		  end
		  class Register < Requirement
		    def eval party, context
		      !party.nil?
		    end
		  end
		end
        class Constraint
          attr_accessor :name
		  @name
		  @xml
		  @context
		  @constraints
		  def self.factory c
		  	Constraint.const_get(c.name.capitalize).new(c)
		  end
		  
		  def initialize c
		    @id = $uuid.generate
		    @name = c.name
		    @xml = c
		    @constraint = []
		    
		    set_context
		    
		    c.xpath('o-ex:constraint/*', 'o-ex' => 'http://odrl.net/1.1/ODRL-EX').each do |c1|
		      constraint = Constraint.factory(c1, c)
		      @constraint << constraint
		    end
		  end
		  def set_context		  	
		    @context = ODRL::Context.from_xml @xml.xpath('o-dd:context')
		  end
          def eval party, context
            true
		  end
		  def eval_constraints party, context
			  @constraint.each do |c|
	            return false if !(c.eval(party, context))
			  end
			  true
		  end
		  class Purpose < Constraint
		  	def eval party, context
		  		return false if !eval_constraints(party, context)
			  	@xml['type'] == @context.purpose
		  	end  
		  end
		  class Industry < Constraint	  
		  	def eval party, context
		  		return false if !eval_constraints(party, context)
			  	@xml['type'] == @context.industry
		  	end  
		  end
		  class Individual < Constraint
		    def eval party, context
		  	  return false if !eval_constraints(party, context)
		      @context.has party
		    end
		  end
		  class Group < Constraint
		    def eval party, context
		  	  return false if !eval_constraints(party, context)
		      party.groups.each do |g|
		        return true if @context.is_in_context g
		      end
		    end
		  end
		  class DateTime < Constraint
		    def eval party, context
		  	  return false if !eval_constraints(party, context)
		      r_start = strptime(@xml.xpath('//o-dd:start').content)
		      r_end = strptime(@xml.xpath('//o-dd:end').content)
		      r_now = DateTime.new
		      r_now <= r_start and r_now <= r_end
		    end
		  end
		  class Recontext < Constraint
		    def eval party, context
		      return false if !eval_constraints(party, context)
		      true
		    end
		  end
		  class Unit < Constraint
		    def eval party, context
		      return false if !eval_constraints(party, context)
		      true
		    end
		  end
		  class Count < Constraint
		    def eval party, context
		      return false if !eval_constraints(party, context)
		      $session[@id]=0 if $session[@id].nil?
		      $session[@id] += 1		      
		      $session[@id] <= @xml.content.to_i
		    end
		  end		  
		  class Range < Constraint
		    def eval party, context
		      return false if !eval_constraints(party, context)
		      $session[@id]=0 if $session[@id].nil?
		      $session[@id] += 1		      
		      r_begin = @xml.xpath('o-dd:min').contents.to_i
		      r_end = @xml.xpath('o-dd:max').contents.to_i
		      $session[@id] >= r_begin and $session[@id] <= r_end 
		    end
		  end
		end
		def eval party, context
		  return true if @requirement.empty? and @constraint.empty?
		  @requirement.each do |r|
            return false if !(r.eval(party, context))
		  end
		  
		  @constraint.each do |c|
            return false if !(c.eval(party, context))
		  end
		  true
		end
	   end
       def eval permission, asset, party, context
         (@permissions.select { |p| p.type == permission}).each do |p|
            return true if p.eval party, context
		end
		false
       end
     end
     
     def doc= doc
       @doc = Nokogiri::XML(doc)
       @doc.xpath('//o-ex:offer', 'o-ex' => 'http://odrl.net/1.1/ODRL-EX').each do |o|
         offer = ODRL::Rights::Offer.new o
         @offer << offer
       end
     end
     def eval permission, asset, party, context
       @offer.each do |o|
         return true if o.eval permission, asset, party, context
       end
       false
     end
     def to_s

     end
  end
  
  class Asset
    attr_accessor :context
  	@context
  end
  
  class Party
    attr_accessor :context
  	@context
  end
  
  class Context    
  	attr_accessor :uid
  
	@uid
	@name
	@role
	@remark
	
	@event
	@date
	@physical_location
	@digital_location
	
	@external
	@transaction
	@service
	@version
	
	@purpose
	@industry
	def self.from_xml c
	  return Context.new
	end
	def has c
		!c.nil?
	end
  end
end
