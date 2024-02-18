# spec/models/course_spec.rb
require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      course = Course.new(name: 'Test Course')
      expect(course).to be_valid
    end

    it 'is not valid without a name' do
      course = Course.new
      expect(course).not_to be_valid
      expect(course.errors[:name]).to include("can't be blank")
    end

    it 'is not valid with a duplicate name' do
      FactoryBot.create(:course, name: 'Test Course')
      course = Course.new(name: 'Test Course')
      expect(course).not_to be_valid
      expect(course.errors[:name]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it 'has many tutors' do
      association = described_class.reflect_on_association(:tutors)
      expect(association.macro).to eq :has_many
    end
  end
end
