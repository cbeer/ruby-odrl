require 'rubygems'
require 'nokogiri'
require 'test/unit'
require 'pp'

# sudo gem install thoughtbot-shoulda -v 2.10.1
require 'shoulda'

require File.join(File.dirname(__FILE__), '..', 'lib', 'odrl', 'odrl')


module ODRL
class ODRLTest < Test::Unit::TestCase
	class UserWGBH
		def name
			"test@wgbh.org"
		end
		def groups
			['test1', 'test']
		end
		def industry
			'Public Broadcasting'
		end
	end
	class UserWBUR
		def name
			"test@wbur.org"
		end
		def groups
			'test'
		end
	end
	class UserWKAR
		def name
			"test@wkar.org"
		end
		def groups
			[]
		end
	end
	class UserScholar
		def industry
			'Academia'
		end
	end
	class UserFan
		def industry
			'Fan'
		end
	end
  def test_simple
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'level_0.xml')).read
    rights.doc = d
    assert_equal true, rights.eval('play', nil, nil, nil)
    assert_raises ODRL::Rights::InsufficientPrivileges do
    	rights.eval('undefined_permission', nil, nil, nil)
    end
  end
  def test_level0
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'level_0.xml')).read
    rights.doc = d
    assert_equal true, rights.eval('play', nil, nil, nil)
    assert_equal true, rights.eval('display', nil, nil, nil)
    assert_equal true, rights.eval('annotate', nil, nil, nil)
    assert_raises ODRL::Rights::InsufficientPrivileges do
    	rights.eval('save', nil, nil, nil)
    end
  end
  def test_level1
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'level_1.xml')).read
    rights.doc = d
    assert_equal true, rights.eval('play', nil, nil, nil)
    assert_equal true, rights.eval('display', nil, nil, nil)
    assert_equal true, rights.eval('annotate', nil, nil, nil)
    assert_equal true, rights.eval('save', nil, nil, nil)
  end
  def test_access_requirements
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'access_register.xml')).read
    rights.doc = d
    assert_raises ODRL::Rights::InsufficientPrivileges do
     rights.eval('play', nil, nil, nil)
    end
    rights.eval('play', nil, {}, nil)
  end
  def test_access_constraints
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'access_wgbh.xml')).read
    rights.doc = d
    assert_raises ODRL::Rights::InsufficientPrivileges do
     rights.eval('play', nil, nil, nil)
    end
    assert_raises ODRL::Rights::InsufficientPrivileges do
    rights.eval('display', nil, nil, nil)
    end
    assert_raises ODRL::Rights::InsufficientPrivileges do
     rights.eval('annotate', nil, nil, nil)
    end
    assert_raises ODRL::Rights::InsufficientPrivileges do
     rights.eval('save', nil, nil, nil)
    end

    assert_equal true, rights.eval('save', nil, UserWGBH.new, nil)
    assert_raises ODRL::Rights::InsufficientPrivileges do
    	rights.eval('save', nil, UserWBUR.new, nil)
    end
  end
  def test_access_group_text
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'access_group_test.xml')).read
    rights.doc = d

    assert_equal true, rights.eval('play', nil, UserWGBH.new, nil)
    assert_equal true, rights.eval('play', nil, UserWBUR.new, nil)
    assert_raises ODRL::Rights::InsufficientPrivileges do
    	rights.eval('play', nil, UserWKAR.new, nil)
    end
  end
  def test_access_industry
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'access_industry.xml')).read
    rights.doc = d

    assert_equal true, rights.eval('play', nil, UserWGBH.new, nil)
    assert_equal true, rights.eval('play', nil, UserScholar.new, nil)
    assert_raises ODRL::Rights::InsufficientPrivileges do
    	rights.eval('play', nil, UserFan.new, nil)
    end
  end
  def test_count
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'count.xml')).read
    rights.doc = d
    assert_equal true, rights.eval('play', nil, nil, nil)
    assert_equal true, rights.eval('play', nil, nil, nil)
    assert_equal true, rights.eval('play', nil, nil, nil)
    assert_equal true, rights.eval('play', nil, nil, nil)
    assert_equal true, rights.eval('play', nil, nil, nil)
    assert_raises ODRL::Rights::InsufficientPrivileges do
    	rights.eval('play', nil, nil, nil)
    end
    assert_raises ODRL::Rights::InsufficientPrivileges do
    	rights.eval('play', nil, nil, nil)
    end
  end
end
end