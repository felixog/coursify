class Section < ActiveRecord::Base
	has_many :lessons, dependent: :destroy

	#acts_as_list
	scope :sorted, lambda { order("sections.position ASC")}
	scope :visible, lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) }
	# scope :sorted, lambda { order("sections.position ASC") }
	scope :newest_first, lambda { order("sections.created_at DESC")}
	scope :search, lambda {|query|
	where(["name LIKE ?", "%#{query}%"])
	}
end
