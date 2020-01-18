require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context 'DB columns' do
    {
      email: :string,
      encrypted_password: :string,
      reset_password_token: :string,
      reset_password_sent_at: :datetime,
      remember_created_at: :datetime
    }.each do |attr, type|
      it "should be created with a column of #{attr}" do
        is_expected.to have_db_column(attr).of_type type
      end
    end
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:encrypted_password) }
end

