require 'rails_helper'

RSpec.describe Application, type: :model do
  it { should have_many(:chats).dependent(:destroy) }
  it { should validate_presence_of(:name) }
end