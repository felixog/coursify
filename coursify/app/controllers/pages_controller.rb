class PagesController < ApplicationController
  before_action :authenticate_admin_user!, only: [:dashboard]
	def index
    if student_user_signed_in?
      redirect_to controller: :studentportal, action: :index
    elsif admin_user_signed_in?
      redirect_to controller: :admin, action: :content
    end 
    @sections  = Section.visible.sorted

	end

  def dashboard
    
  end


  def home
    @sections  = Section.visible.sorted
  end

  def onboard
    if !student_user_signed_in?
      redirect_to :enroll
    end 
    @message = Message.new
  end

  def onboard_send
    @message = Message.new(params[:message])
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(portal_path) #, :notice => "Hurray! We have recieved your message."
    else
      flash.now.alert = "Please fill all fields."
      render :onboard
    end    
  end

	def enroll
    if student_user_signed_in?
      redirect_to controller: :studentportal, action: :index
    end 
		@message = Message.new
    @studentuser = StudentUser.new
	end

	def create
    @message = Message.new(params[:message])
    @studentuser = StudentUser.new(student_user_params)
    @amount = current_price_stripe      

    if params[:message][:password].blank?
      params[:message].delete(:password)
      params[:message].delete(:password_confirmation)
    end

    respond_to do |format|
      
      if @studentuser.save
        

        customer = Stripe::Customer.create(
          :email => @studentuser.email,
          :card  => params[:stripeToken]
        )

        charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount,
          :description => 'Reservation',
          :currency    => 'usd'
        )
        if charge["paid"] == true
          sign_in @studentuser
          format.html { redirect_to onboard_path, notice: 'Congratulations! You have sucessfully signed-up for OneDayRails.' }
        end

      else
        format.html { render action: "enroll" }
      end
    end

    rescue Stripe::CardError => e
      respond_to do |format|
          @studentuser.destroy
          flash[:stripe] = e.message
          format.html { render action: "enroll" }
      end
    # 
  end 



  private

  def student_user_params
    params.require(:message).permit(:name,:email, :password, :password_confirmation)
  end 
end

