require_relative '../../test_base'

class Donations::Paypal::Customer::FindOrUpdateTest < Donations::TestBase
  test "returns existing user with matching paypal_payer_id" do
    email = "#{SecureRandom.uuid}@bar.com"
    paypal_payer_id = SecureRandom.uuid
    user = create(:user, paypal_payer_id:, email:)

    found_user = Donations::Paypal::Customer::FindOrUpdate.(paypal_payer_id, email)

    assert_equal user, found_user
  end

  test "updates existing user with matching email" do
    email = "#{SecureRandom.uuid}@bar.com"
    paypal_payer_id = SecureRandom.uuid

    user = create(:user, email:)

    found_user = Donations::Paypal::Customer::FindOrUpdate.(paypal_payer_id, email)

    assert_equal user, found_user
    assert_equal paypal_payer_id, found_user.paypal_payer_id
  end

  test "returns nil when no user with matching email or paypal_payer_id could be found" do
    email = "#{SecureRandom.uuid}@bar.com"
    paypal_payer_id = SecureRandom.uuid

    user = Donations::Paypal::Customer::FindOrUpdate.(paypal_payer_id, email)

    assert_nil user
  end
end
