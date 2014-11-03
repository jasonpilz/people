class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def show
    @person = Person.find_by_slug(params[:id])
  end

  def edit
    @person = current_person
  end

  def update
    @person = current_person
    Person.editable_attributes.each do |attr|
      @person.send("#{attr}=", params[:person][attr])
    end
    @person.save!
    redirect_to person_path(@person)
  end

  def create
    @person = Person.new(:user_id => current_user.id)
    Person.editable_attributes.each do |attr|
      @person.send("#{attr}=", params[:person][attr])
    end
    @person.save!
    redirect_to person_path(@person)
  end

  def new
    @person = Person.new
  end
end