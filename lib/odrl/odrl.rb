#require 'nokogiri'
require 'uuid'

$uuid = UUID.new
$session = {}

module ODRL
   module Rights

   end
end

require File.dirname(__FILE__) + "/context"
require File.dirname(__FILE__) + "/asset"
require File.dirname(__FILE__) + "/party"
require File.dirname(__FILE__) + "/requirement"
require File.dirname(__FILE__) + "/constraint"
require File.dirname(__FILE__) + "/permission"
require File.dirname(__FILE__) + "/offer"
require File.dirname(__FILE__) + "/document"
require File.dirname(__FILE__) + "/exceptions"
