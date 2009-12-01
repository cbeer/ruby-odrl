require 'dispatcher'
require 'odrl/lib/odrl'
 
module Rights_DocumentPatch
        def self.included(base)
                base.extend(ClassMethods)
                base.send(:include, InstanceMethods)
        end
 
        module ClassMethods
 
        end
 
        module InstanceMethods
        end
end
 
module Rights_UserPatch
        def self.included(base)
                base.extend(ClassMethods)
                base.send(:include, InstanceMethods)
        end
 
        module ClassMethods
        end
 
        module InstanceMethods
		def uid
			email
		end
		def name
			email
		end
		def groups
			tags
		end
        end
end
 
 
Dispatcher.to_prepare do
  SolrDocument.send(:include, Rights_DocumentPatch)
  User.send(:include, Rights_UserPatch)
  User.acts_as_taggable
end
