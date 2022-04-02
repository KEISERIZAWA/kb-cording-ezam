class StudentsController < ApplicationController
    before_action :authenticate_user! , except: [:index]
    def index
        if params[:search] != nil && params[:search] != ''
            #部分検索かつ複数検索
            search = params[:search]
            @students = Student.where("name LIKE ? OR profile LIKE ? OR mentor LIKE ? OR grade LIKE ?", "%#{search}%", "%#{search}%",  "%#{search}%", "%#{search}%")
          else
            @students = Student.all
          end
      @students = Student.all
    end
  
    def new
      @student = Student.new
    end
  
    def create
      student = Student.new(student_params)
      student.user_id = current_user.id
      if student.save
        redirect_to :action => "index"
      else
        redirect_to :action => "new"
      end
    end

    def show
        @student = Student.find(params[:id])
    end
  
    def edit
      @student = Student.find(params[:id])
    end
  
    def update
        student = Student.find(params[:id])
        if student.update(student_params)
        redirect_to :action => "show", :id => student.id
        else
        redirect_to :action => "new"
        end
    end
  
    def destroy
        student = Student.find(params[:id])
        student.destroy
        redirect_to action: :index
    end
  
  private
    def student_params
        params.require(:student).permit(:name, :profile, :mentor, :grade)
    end
  
end
