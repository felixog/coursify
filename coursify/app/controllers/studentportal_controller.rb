class StudentportalController < ApplicationController
  layout "portal"
  before_action :authenticate_student_user!
  before_action :setup_navigation
  before_action :find_section, except: [:index, :done, :next_page]
  
  def index
    first_section = Section.where(:position => 1).first
    @first_lesson =  Lesson.where(:section_id => first_section.id, :position => 1).first     
    @current_student_user = current_student_user
    if current_student_user.last_viewed_lecture
      @last_lesson = Lesson.where(:permalink => current_student_user.last_viewed_lecture, :visible => true).first
    end
  end

  def done
  end

  def show
    @lesson = Lesson.where(:permalink => params[:permalink], :visible => true).first

    
    if @lesson.nil?
      redirect_to(:action => "index")
    else    
      
      current_student_user.update_attribute(:last_viewed_lecture, @lesson.permalink)
      @current_student_user = current_student_user

      @permalink = params[:permalink]
      @lesson = Lesson.where(:permalink => params[:permalink], :visible => true).first      
      @sections_all = Section.all.size
      @current_section = current_section
      @current_section_size = size_of_section(@current_section)
      @current_lesson_position = lesson_position(@lesson)
      
      if @current_lesson_position <= (@current_section_size - 1)
        @next_lesson_position = @current_lesson_position + 1
        @next_lesson_object = Lesson.where(:section_id => @current_section.id, :position => @next_lesson_position).first      
      elsif @current_lesson_position == @current_section_size
        if @current_section.position == @sections_all
          @next_lesson_object = Lesson.new(:name => "Conclusion...")
          return false
        end    
        @next_section = next_section
        
        while @next_section.lessons.size < 1
          if @next_section.position == @sections_all
            @next_lesson_object = Lesson.new(:name => "Conclusion...")
            return false
            break
          else
            cs = @next_section.position
            if cs <= (@sections_all - 1)
              nxt_section_position = cs + 1 
              nxt_section = Section.where(:position => nxt_section_position).first
              @next_section = nxt_section
            end
          end
        end        

        @next_lesson_object = Lesson.where(:section_id => @next_section.id, :position => 1).first           
      end
    end
  end

  def next_page
    @permalink = params[:permalink]
    @lesson = Lesson.where(:permalink => params[:permalink], :visible => true).first      
    @sections_all = Section.all.size
    @current_section = current_section
    @current_section_size = size_of_section(@current_section)
    @current_lesson_position = lesson_position(@lesson)
    
    if @current_lesson_position <= (@current_section_size - 1)
      @next_lesson_position = @current_lesson_position + 1
      @next_lesson_object = Lesson.where(:section_id => @current_section.id, :position => @next_lesson_position).first
      redirect_to "/portal/#{@next_lesson_object.permalink}"       
    elsif @current_lesson_position == @current_section_size
      if @current_section.position == @sections_all
        redirect_to coming_soon_path
        return false
      end    
      @next_section = next_section
      
      while @next_section.lessons.size < 1
        if @next_section.position == @sections_all
          redirect_to coming_soon_path
          return false
          break
        else
          cs = @next_section.position
          if cs <= (@sections_all - 1)
            nxt_section_position = cs + 1 
            nxt_section = Section.where(:position => nxt_section_position).first
            @next_section = nxt_section
          end
        end
      end        

      @next_lesson_object = Lesson.where(:section_id => @next_section.id, :position => 1).first     
      redirect_to "/portal/#{@next_lesson_object.permalink}"
    end
  end

  private

  def setup_navigation
    @sections  = Section.visible.sorted
  end

  def find_section
    lesson = Lesson.where(:permalink => params[:permalink], :visible => true).first
    # @section_id = @lesson.section_id
    @section = Section.find(lesson.section_id)
  end

  def next_section
    cs = @current_section.position
    if cs <= (@sections_all - 1)
      nxt_section_position = cs + 1 
      nxt_section = Section.where(:position => nxt_section_position).first
      return nxt_section
    end       
  end

  def current_section
    @lesson = Lesson.where(:permalink => params[:permalink], :visible => true).first
      @section_id = @lesson.section_id
      return Section.find(@section_id)    
  end

  def size_of_section(section)
    section_size = section.lessons.size
    return section_size
  end

  def lesson_position(lesson)
    lp = lesson.position
    return lp
  end



  # def next_lesson_position(lesson)
  #   current_lesson_position = lesson_position(lesson)
  #   section_size = size_of_section(what_section)

  #   if section_size >= (current_lesson_position + 1)
  #     n_l_p = current_lesson_position + 1
  #     return n_l_p
  #   else
  #     find_next_section(what_section)
  #   end

  #   lpp = lpp +1
  #   return lpp
  # end
end