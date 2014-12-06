require 'test_helper'

class Sms::InboundMessagesControllerTest < ActionController::TestCase
  setup do
    TextMessage.any_instance.expects(:process_later).once
  end

  test 'create' do
    assert_difference -> { TextMessage.count } do
      post :create, From: '+15558675309', Body: 'hello!'
    end
    assert_response :ok
    assert_equal '+15558675309', TextMessage.last.phone_number
    assert_equal 'hello!', TextMessage.last.body
  end

  test 'create strips leading and trailing whitespace from text message bodies' do
    post :create, From: '+15558675309', Body: '  hello, my friend!   '
    assert_response :ok
    assert_equal 'hello, my friend!', TextMessage.last.body
  end
end
