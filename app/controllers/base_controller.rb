class BaseController < ApplicationController
  def create
    @course = find_or_create_course(course_params)
    @course.tutors.build(tutors_params) 
    if @course.save
      render json: { course: @course, tutors: @course.tutors }, status: :created
    else
      render json: { error: @course.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end

  def tutors_params
    params.fetch(:tutors).map { |tutor| tutor.permit(:name, :email) }
  end

  def find_or_create_course(course_params)
    Course.find_or_create_by(course_params)
  end
end
