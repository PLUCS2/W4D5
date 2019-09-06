require 'rails_helper'

RSpec.describe UsersController, type: :controller do 

  describe 'GET #new' do 
    it 'renders the new view' do 
      get(:new)
      expect(response).to render_template(:new)
    end 
  end 

  describe 'POST #create' do
    let(:valid_params) { {user: { username: "Bob", password: "starwars"}}}
    let(:invalid_params) { {user: { username: "Bob", password: "st"}}}
    context 'with valid params' do 
      it 'creates user' do
        post(:create, params: valid_params)
        expect(User.last.username).to eq("Bob")
      end
      it 'redirects to user#show page' do
        post(:create, params: valid_params)
        expect(response).to redirect_to(user_url(User.last.id))
      end
    end
    context 'with invalid params' do 
      it 'renders new form' do
        post(:create, params: invalid_params)
        expect(response).to render_template(:new)
      end
      it 'adds errors to flash' do
        post(:create, params: invalid_params)
        expect(flash[:errors]).to be_present
      end
    end
  end

  describe 'GET #show' do
    before :each do 
      create(:user)
    end
    it 'renders the user#show view' do
      get(:show, params: {id: User.last.id}) 
      expect(response).to render_template(:show)
    end
  end

end 