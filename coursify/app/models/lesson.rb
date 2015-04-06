class Lesson < ActiveRecord::Base
	belongs_to :section

	acts_as_list :scope => :section

	before_validation :add_default_permalink
	after_save :touch_section

	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_presence_of :permalink
	validates_length_of :permalink, :within => 3..255
	validates_uniqueness_of :permalink


	scope :visible, lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) }
	scope :sorted, lambda { order("lessons.position ASC") }
	scope :newest_first, lambda { order("lessons.created_at DESC")}

	private

		def add_default_permalink
			if permalink.blank?
				self.permalink = "#{id}-#{name.parameterize}"
			end
		end

		def touch_section
			section.touch
		end

end
