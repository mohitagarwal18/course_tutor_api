require 'rails_helper'

RSpec.describe BaseController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          course: { name: 'Test Course' },
          tutors: [{ name: 'Test Tutor 1', email: 'test1@example.com' }]
        }
      end

      it 'creates a new course with tutors' do
        expect {
          post :create, params: valid_params
        }.to change(Course, :count).by(1)
         .and change(Tutor, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          course: { name: '' }, # Invalid name
          tutors: [{ name: 'Test Tutor', email: '' }] # Invalid email
        }
      end

      it 'returns unprocessable_entity status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
