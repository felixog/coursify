module ApplicationHelper

	def error_messages_for(object)
		render(:partial => 'application/error_messages', :locals => {:object => object})
		
	end
	def status_tag(boolean, options={})
		options[:true_text] ||= ""
		options[:false_text] ||= ""


		if boolean
			content_tag(:span, options[:true_text], :class => "status true")
		else
			content_tag(:span, options[:false_text], :class => "status false")
		end
			
	end

	def after_sign_in_path_for(admin_user)
	  admin_path
	end


	def after_sign_in_path_for(student_user)
	  portal_path
	end



	def devise_error_messages(resource)
	    return '' if resource.errors.empty?

	    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
	    html = <<-HTML
	    <div data-alert style="margin:4px; margin-bottom:12px;" class=" ca alert-box radius alert">
	                #{messages}
	                <a href="#" class="close">&times;</a>
	              </div>
	    HTML

	    html.html_safe
	end

	def devise_error_messages_stripe(resource)
	    return '' if resource.errors.empty?

	    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
	    html = <<-HTML
	    <div data-alert style="margin:4px; margin-bottom:12px;" class=" ca alert-box radius alert">
	                #{messages}
	                <li><strong>Your Card Has Not Been Charged.</strong></li>
	                <a href="#" class="close">&times;</a>
	              </div>
	    HTML

	    html.html_safe
	end

	


	def current_price
		pricing
		if @incremental
			s = StudentUser.all
			count = s.size
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
			s = StudentUser.all
			count = s.size
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
			s = StudentUser.all
			count = s.size
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
