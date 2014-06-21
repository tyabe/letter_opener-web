require File.expand_path(File.dirname(__FILE__) + '/helper')

describe LetterOpener::Web::App do

  before do
    Mail.new {
      from    'foo@example.com'
      to      'bar@example.com'
      subject '<h1>Hello</h1>'
      body    'World!'
    }.deliver!
  end

  it 'can display index' do
    visit '/'

    assert_equal page.status_code, 200
    assert page.has_content? 'Hello'
    within_frame 'mail' do
      assert ! page.has_content?('World!')
    end
  end

  it 'can display message' do
    visit '/'
    click_link 'Hello'

    within_frame 'mail' do
      assert page.has_content? 'World!'
    end
  end

  it 'subject of the message are escaped' do
    visit '/'
    assert page.has_content? '<h1>Hello</h1>'
  end

end
