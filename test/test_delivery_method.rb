require File.expand_path(File.dirname(__FILE__) + '/helper')
require 'yaml'

describe LetterOpener::DeliveryMethod do

  let(:plain_file)  { Dir["#{test_location}/*/plain.html"].first  }
  let(:info_file)   { Dir["#{test_location}/*/info.yml"].first    }
  let(:info)        { YAML.load_file(info_file) }

  it 'raises an exception if no location passed' do
    LetterOpener.location = nil
    assert_raises(LetterOpener::DeliveryMethod::InvalidOption) { LetterOpener::DeliveryMethod.new }
    LetterOpener.location = test_location
    LetterOpener::DeliveryMethod.new
  end

  describe 'using deliver! method' do
    before do
      Mail.new {
        from    'foo@example.com'
        to      'bar@example.com'
        subject 'Hello'
        body    'World!'
      }.deliver!
    end

    it 'creates plain html document' do
      assert File.exist?(plain_file)
    end
    it 'creates infomation file' do
      assert File.exist?(info_file)
    end
    it 'saves a Subject into the infomation file' do
      assert info[:subject], 'Hello'
    end
    it 'saves a To into the infomation file' do
      assert info[:to], 'foo@example.com'
    end
    it 'saves a From into the infomation file' do
      assert info[:from], 'bar@example.com'
    end

  end

end
