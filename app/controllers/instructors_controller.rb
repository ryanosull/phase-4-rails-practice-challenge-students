class InstructorsController < ApplicationController

    # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Instructor.all, status: :ok 
    end

    def show
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            render json: instructor, status: :ok 
        else
            render json: {errors: ["Instructor not found!"]}, status: 404
        end
    end

    def create
        instructor = Instructor.create!(instructor_params)
        if instructor
            render json: instructor, status: :ok
        else
            render json: student.errors.full_messages, status: 422
        end
    end

    def destroy 
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.destroy
            render json: {messages: ["Successfully deleted instructor with the ID of #{instructor.id}!"]}, status: :ok
        else
            render json: {errors: ["Instructor not found"]}, status: 404
        end
    end

    private
    def instructor_params
        params.require(:instructor).permit(:name)
    end




    #
end
