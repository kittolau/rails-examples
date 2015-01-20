#used for mass assignment
class PeopleController < ApplicationController
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :bio, :birthday)
      #for has many, model default has XXX_ids
      #so you can use "group_ids"
      #for nested attributes
      #location_attributes: [:name, :_destroy]
      params.require(:event).permit(:name, :description,:category_id, location_attributes: [:name, :_destroy], group_ids: [])
    end
end
