class Message

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :subject, :questionone, :questiontwo, :password, :password_confirmation
  #password and password confirmation are not used. They are only there to allow the validations to pass for the signup form.
  
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end
