require 'rubygems'
require 'test/unit'

# sudo gem install thoughtbot-shoulda -v 2.10.1
require 'shoulda'

require File.join(File.dirname(__FILE__), '..', 'lib', 'odrl', 'odrl')


module ODRL
class ODRLTest < Test::Unit::TestCase
  def test_simple
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'level_0.xml')).read
    rights.doc = d
    assert_equal true, rights.eval('play', nil, nil, nil)
    assert_equal false, rights.eval('undefined_permission', nil, nil, nil)
  end
  def test_level0
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'level_0.xml')).read
    rights.doc = d
    assert_equal true, rights.eval('play', nil, nil, nil)
    assert_equal true, rights.eval('display', nil, nil, nil)
    assert_equal true, rights.eval('annotate', nil, nil, nil)
    assert_equal false, rights.eval('save', nil, nil, nil)
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
  def test_access_constraints
    rights = ODRL::Rights::Document.new
    d = open(File.join(File.dirname(__FILE__), 'access_wgbh.xml')).read
    rights.doc = d
    assert_equal false, rights.eval('play', nil, nil, nil)
    assert_equal false, rights.eval('display', nil, nil, nil)
    assert_equal false, rights.eval('annotate', nil, nil, nil)
    assert_equal false, rights.eval('save', nil, nil, nil)

    assert_equal true, rights.eval('save', nil, {}, nil)
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
    assert_equal false, rights.eval('play', nil, nil, nil)
    assert_equal false, rights.eval('play', nil, nil, nil)
  end
end
end
