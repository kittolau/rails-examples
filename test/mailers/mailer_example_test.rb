require 'test_helper'

class MailerExampleTest < ActionMailer::TestCase
  test "textAction" do
    mail = MailerExample.textAction
    assert_equal "Textaction", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
