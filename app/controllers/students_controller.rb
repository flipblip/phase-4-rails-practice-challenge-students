class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Student.all, status: :ok
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def show
        student = Student.find_by(id:params[:id])
        if student
            render json: student, status: :ok
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

    def destroy
        student = Student.find_by(id:params[:id])
        if student
            student.destroy
            head :no_content
        else
            render json: {error: "Student not found"},
            status: :not_found
        end
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}
    end

    def record_not_found
        render json: {error: "Record not found"}, status: 404
    end
end
