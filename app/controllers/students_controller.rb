class StudentsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def show
        student = Student.find_by(id: params[:id])
        if student
            render json: student, status: :ok
        else
            render json: {errors: ["Student not found!"]}, status: 404 
        end
    end

    # def show
    #     student = Student.find(params[:id])
    #     render json: student, status: :ok
    # end

    def create
        student = Student.create!(student_params)
        if student
            render json: student, status: :ok #201
        else
            render json: student.errors.full_messages, status: 422
        end
    end

    def destroy
        student = Student.find_by(id: params[:id])
        if student
            student.destroy
            render json: {messages: ["Successfully deleted student with the ID of #{student.id}!"]}, status: :ok
        else
            render json: {errors: ["Student not found"]}, status: 404
        end
    end





    private
    # def render_not_found_response(invalid)
    #     render json: {errors: invalid.record.errors}, status: :not_found
    # end

    def student_params
        params.require(:student).permit(:name, :age, :instructor_id, :major)
    end




    #
end
