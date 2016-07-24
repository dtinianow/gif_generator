require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:username)}
    it { is_expected.to validate_uniqueness_of(:username)}
    it { should define_enum_for(:role).with([:default, :admin]) }
  end
end
