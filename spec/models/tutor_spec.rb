require 'rails_helper'

RSpec.describe Tutor, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      course = FactoryBot.create(:course)
      tutor = Tutor.new(name: 'Test Tutor', email: 'test@example.com', course_id: course.id)
      expect(tutor).to be_valid
    end

    it 'is not valid without a name' do
      tutor = Tutor.new(email: 'test@example.com')
      expect(tutor).not_to be_valid
      expect(tutor.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without an email' do
      tutor = Tutor.new(name: 'Test Tutor')
      expect(tutor).not_to be_valid
      expect(tutor.errors[:email]).to include("can't be blank")
    end

    it 'is not valid with an invalid email format' do
      tutor = Tutor.new(name: 'Test Tutor', email: 'invalid-email')
      expect(tutor).not_to be_valid
      expect(tutor.errors[:email]).to include('is invalid')
    end

    it 'is not valid with a duplicate email' do
      existing_tutor = FactoryBot.create(:tutor, email: 'test@example.com')
      tutor = Tutor.new(name: 'Test Tutor', email: 'test@example.com')
      expect(tutor).not_to be_valid
      expect(tutor.errors[:email]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it 'belongs to course' do
      association = described_class.reflect_on_association(:course)
      expect(association.macro).to eq :belongs_to
    end
  end
end
