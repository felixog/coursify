class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable :recoverable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
end
