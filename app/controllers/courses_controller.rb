class CoursesController < ApplicationController
  def index
    page_number = params[:page].to_i
    page_number = 1 unless page_number.positive?
    
    per_page = params[:page_size].to_i
    per_page = 25 unless per_page.positive?

    offset = (page_number - 1) * per_page

    @courses = Course.limit(per_page).offset(offset)
    render json: @courses, include: :tutors
  end

  def show
    @course = Course.find_by(id: params[:id])
    render json: @course, include: :tutors
  end
end