class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def show
    id = params[:id]
    @question = Question.find(id)
    @prev_question = Question.order(id: :desc).find_by('questions.id < ?', id) || Question.last
    @next_question = Question.order(id: :asc).find_by('questions.id > ?', id) || Question.first
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(questions_params)
      redirect_to questions_url
    else
      render :edit
    end
  end

  def create
    @question = Question.new(questions_params)
    if @question.save
      redirect_to questions_url
    else
      render :new
    end
  end

private

  def questions_params
    params.require(:question).permit(:question, :answer)
  end
end
