require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "signup" do
    user = User.first
    mail = UserMailer.signup(user)
    assert_equal "Welcome to sms2email!", mail.subject
    #assert_equal ["to@example.org"], mail.to
    assert_equal ["mailer@zzv.ca"], mail.from
    assert_match "Thank you for signing up", mail.body.encoded
  end
end
