require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:session_token)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_length_of(:password).is_at_least(6)}

  describe 'uniqueness' do
    before :each do 
      create(:user)
    end 
    it {should validate_uniqueness_of(:username)}
    it {should validate_uniqueness_of(:session_token)}
  end

  describe 'ensure_session_token' do 
    before :each do 
      create(:user)
      #if you want to say user in it block: let(:user) {create(:user)}
    end 
    it 'makes sure user.session_token is not nil' do
      expect(User.last.session_token).to_not eq(nil)
    end 
  end 

  describe 'generate_session_token' do 
    it 'checks length of session token' do 
      expect(User.generate_session_token.length).to eq(22)
    end   
    it 'checks that session token is type string' do 
    expect(User.generate_session_token).to be_instance_of(String)
    end 
  end 

  describe 'find_by_credentials' do
    before :each do 
      create(:user)
    end
    it 'find the correct user'  do
      expect(User.find_by_credentials("Not The Name", "starwars")).to eq(nil)
    end
    it 'validates password' do
      expect(User.find_by_credentials(User.last.username, "Not Password")).to eq(nil)
    end
    it 'returns user' do
      expect(User.find_by_credentials(User.last.username, "starwars")).to eq(User.last)
    end
  end

  describe 'reset_session_token!' do 
      let(:user) { create(:user) }
    it 'produces new session token' do 
      expect(user.session_token).to_not eq(user.reset_session_token!)
    end 
  end 
  
end