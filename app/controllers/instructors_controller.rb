class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Instructor.all, status: :ok
    end

    def create
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :created
    end

    def show
        instructor = Instructor.find_by(id:params[:id])
        if instructor
            render json: instructor, include: :students, status: :ok
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end

    def destroy
        instructor = Instructor.find_by(id:params[:id])
        if instructor
            instructor.destroy
            head :no_content
        else
            render json: {error: "Instructor not found"},
            status: :not_found
        end
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}
    end

    def record_not_found
        render json: {error: "Record not found"}, status: 404
    end
end
