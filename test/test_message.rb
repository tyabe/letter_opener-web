require File.expand_path(File.dirname(__FILE__) + '/helper')

describe LetterOpener::Web::Message do

  before do
    2.times do
      Mail.new {
        from    'foo@example.com'
        to      'bar@example.com'
        subject 'Hello'
        body    'World!'
      }.deliver!
    end
  end

  describe '.location' do
    it 'return LetterOpener#location' do
      assert_equal LetterOpener::Web::Message.location, LetterOpener.location
    end
  end

  describe '.load_all' do
    subject { LetterOpener::Web::Message.load_all }
    it 'returns a list of messages' do
      assert_equal subject.count, 2
    end
  end

  describe '.find' do
    let(:id) { '1111111111_1111111' }
    subject { LetterOpener::Web::Message.find id }
    it 'returns a message with id set' do
      assert_equal subject.id, id
    end
  end

  describe '.bulk_delete' do
    it 'removes all specified messages' do
      ids = LetterOpener::Web::Message.load_all.map(&:id)
      assert_equal ids.count, 2
      LetterOpener::Web::Message.bulk_delete(ids)
      assert_equal LetterOpener::Web::Message.load_all.count, 0
    end
  end

end
