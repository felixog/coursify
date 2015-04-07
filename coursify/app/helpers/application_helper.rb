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
	
end
