require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns courses with default pagination' do
      FactoryBot.create_list(:course, 30) # Create 30 courses for testing pagination
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:courses).count).to eq(25) # Default per_page is 25
    end

    it 'returns courses with custom pagination' do
      FactoryBot.create_list(:course, 30) # Create 30 courses for testing pagination
      get :index, params: { page: 2, page_size: 10 } # Requesting page 2 with 10 per page
      expect(response).to have_http_status(:success)
      expect(assigns(:courses).count).to eq(10) # Should return 10 courses
    end
  end

  describe 'GET #show' do
    let(:course) { FactoryBot.create(:course) }

    it 'returns a successful response' do
      get :show, params: { id: course.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns the requested course with tutors included' do
      tutor = FactoryBot.create(:tutor, course: course) # Create a tutor associated with the course
      get :show, params: { id: course.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:course)).to eq(course)
      expect(assigns(:course).tutors).to include(tutor)
    end
  end
end
