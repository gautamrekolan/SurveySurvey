class SurveysController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  #before_filder :require_user
  
  def index
    @surveys = Survey.all
  end
  
  def show
    @survey = Survey.find(params[:id])
    @questions = Question.find(:all, :order => 'question_order')
#    respond_to do |format|
#      format.html
#      format.csv do
#        csv_string = FasterCSV.generate do |csv|
#          csv << ["id", "question_id", "answer_id", "user_id"]
#          @responses.each do |response|
#            csv << [response.id, response.question_id, response.answer_id, response.user_id]
#          end
#        end
#     end
#      send_data csv_string,
#        :type => 'text/csv; charset=iso-8859-1; header=present',
#        :disposition => "attachment; filename=responses.csv"
#    end
  end
  
  def new
    @survey = Survey.new
    2.times do
      question = @survey.questions.build
      2.times { question.answers.build }
    end
  end
  
  def create
    @survey = current_user.surveys.build(params[:survey])
    if @survey.save
      flash[:success] = "Successfully created survey."
      redirect_to @survey
    else
      flash[:notice] = "Survey NOT Created"
      render :action => 'new'
    end
  end
  
  def edit
    @survey = Survey.find(params[:id])
  end
  
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated survey."
      redirect_to @survey
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    flash[:notice] = "Successfully destroyed survey."
    redirect_to surveys_url
  end
  
  def respond
    responses = params[:responses].first
    user = current_user
    tosave = []
    responses.each do |r|
      answers = r.last
      answers.each do |a|
        response = Response.new
        response.question_id = r.first
        response.answer_id = a
        tosave << response
      end
    end
    tosave.each do |r|
      r.user = user
      r.save!
    end
    flash[:notice] = "Thanks for Submitting Your Survey"
    redirect_to surveys_url
  end
  
end