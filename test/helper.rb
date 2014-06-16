$: << File.expand_path(File.join(File.dirname(__FILE__),'..','lib'))
require 'rack/test'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'mail'
require 'letter_opener/web'
if RUBY_VERSION >= '2.0'
  require 'minitest-power_assert'
end

class MiniTest::Spec
  include Rack::Test::Methods
  def app
    LetterOpener::Web::App
  end
end
class Minitest::SharedExamples < Module
  include Minitest::Spec::DSL
end

def test_location
  @test_locatino ||= File.expand_path('tmp/letter_opener', File.dirname(__FILE__))
end

LetterOpener.location = test_location
Mail.defaults do
  delivery_method LetterOpener::DeliveryMethod
end

MiniTest::Spec.after do
  FileUtils.rm_rf(test_location)
end
