class AnimalsController < ApplicationController
    load_and_authorize_resource
  before_action :set_animal, only: [:show, :edit, :update, :destroy]

  # GET /animals
  # GET /animals.json
  def index
    @animals = Animal.all
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
  end

  # POST /animals
  # POST /animals.json
  def create
    @animal = Animal.new(animal_params)


    respond_to do |format|
      if @animal.save
        format.html { redirect_to @animal, notice: 'Animal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @animal }
      else
        format.html { render action: 'new' }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end




  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to @animal, notice: 'Animal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @quiz=Quiz.where(animal_id: @animal.id)
    @quiz2=Quiz.where(alternative_id:  @animal.id)
    @quiz.each do |q|
      q.destroy
    end
    @quiz2.each do |p|
      p.destroy
    end
    @animal.destroy
    respond_to do |format|
      format.html { redirect_to animals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_params
      params.require(:animal).permit(:name, :avatar, :sound)
    end
end

