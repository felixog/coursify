class AdminController < ApplicationController
  layout "portal"
  before_action :authenticate_admin_user!
  before_action :find_sections, except: [:section_sort]

  def content
  end

  def settings
  end
  #crud Lessons
  def lesson_new
    find_section
    @lesson = Lesson.new({:section_id => @section.id})    

    @lesson_count = @section.lessons.count + 1
    @lesson_position = @lesson_count
    
  end

  def lesson_create
    @lesson = Lesson.new(lesson_params)
    find_section
    if @lesson.save
      flash[:notice] = "This Lesson Was Successfully Created"      
      redirect_to(:action => "section_show", :id => @section.id)
    else
      # @sections = Section.order('position ASC')
      @lesson_count = @section.lessons.count + 1
      @lesson_position = @lesson_count
      render("lesson_new")
    end       
  end

  def lesson_edit
    @lesson = Lesson.find(params[:id])

    # @sections = Section.order('position ASC')
    find_section
    @lesson_count = @section.lessons.count
    @lesson_position = @lesson.position
  end

  def lesson_update
    @lesson = Lesson.find(params[:id])
    find_section
    if @lesson.update_attributes(lesson_params)      
      flash[:notice] = "This Lesson Was Successfully Updated"
      redirect_to(:action => "lesson_edit", :id => @lesson.id, :section_id => @section.id)
    else
      
      @lesson_count = @section.lessons.count
      @lesson_position = @lesson.position
      render("lesson_edit")
    end 
    
  end

  def lesson_destroy
    find_section
    lesson = Lesson.find(params[:id]).destroy
    flash[:notice] = "Lesson '#{lesson.name}' destroyed Successfully"
    redirect_to(:action => "section_show", :id => @section.id)

  end

  #crud Lessons ends

  #crud Sections
  def section_new
    @section = Section.new
    @section_count = Section.count + 1
    @section_position =  @section_count
  end

  def section_create
    @section = Section.new(section_params)

    if @section.save
      flash[:notice] = "Section Created Successfully. Now you can add lessons to this section"
      redirect_to(:action => "section_show", :id => @section.id)
    else
      @section_count = Section.count + 1
      @section_position =  @section_count
      render("section_new")
    end
  end
  
  def section_show
  	@section = Section.find(params[:id])
  end

  def section_edit
    @section = Section.find(params[:id])
    @section_count = Section.count
    @section_position = @section.position
  end

  def section_update
    @section = Section.find(params[:id])

    if @section.update_attributes(section_params)
      flash[:notice] = "Section Updated Successfully"
      redirect_to(:action => "section_show", :id => @section.id)
    else
      @section_count = Section.count 
      @section_position = @section.position
      render("section_edit")
    end
  end

  def section_destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section '#{section.name}' destroyed Successfully"
    redirect_to(:action => "content")    
  end
  #crud Sections ends

  def section_sort
    params[:section].each_with_index do |id, index|
      s = Section.find(id)
      s.update_attribute(:position, index+1)
      # Section.update_all({position: index+1}, {id: id})
    end
    render :nothing => true
  end

  def lesson_sort
    params[:lesson].each_with_index do |id, index|
      l = Lesson.find(id)
      l.update_attribute(:position, index+1)
      # Section.update_all({position: index+1}, {id: id})
    end
    render :nothing => true
  end

  private

  def find_sections
  	@sections = Section.order('position')
  end

  def find_section
    if params[:section_id]
      @section = Section.find(params[:section_id])
    end
    
  end

  def section_params
    params.require(:section).permit(:name, :position, :visible)
  end


  def lesson_params
    params.require(:lesson).permit(:section_id, :name, :permalink, :position, :visible, :body)
  end
end
