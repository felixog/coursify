class ApplicationController < ActionController::Base
  helper_method :current_price, :max_price_reached?, :current_price_stripe, :pricing, :final_course_price
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def after_sign_in_path_for(admin_user)
  #   redirect_to admin_url
  # end

 
  private

  def current_price
    pricing
    if @incremental
      count = StudentUser.count
      if count >= @final_price
        cprice = @final_price
        return cprice
      else
        if count < 1
          cprice = 1
          return cprice
        else
          cprice = count
          return cprice
        end
      end     
    else
      return @final_price
    end
    
  end

  def max_price_reached?
    pricing
    if @incremental     
      count = StudentUser.count
      if count >= @final_price
        cprice = @final_price
        return true
      else
        if count < 1
          cprice = 1
          return false
        else
          cprice = count
          return false
        end
      end
    else
    return true     
    end
    
  end

  def current_price_stripe
    pricing
    if @incremental
      count = StudentUser.count
      if count >= @final_price
        cprice = @final_price
        return cprice*100
      else
        if count < 1
          cprice = 1
          return cprice*100
        else
          cprice = count
          return cprice*100
        end
      end
    else
      return @final_price*100
    end
  end

  def pricing
    @incremental = false
    @final_price = 39
  end

  def final_course_price
    pricing
    return @final_price   
  end
end
