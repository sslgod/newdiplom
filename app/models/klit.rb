class Klit < ActiveRecord::Base

	belongs_to :kplan

end
# == Schema Information
#
# Table name: klits
#
#  id         :integer         not null, primary key
#  kplan_id   :integer		plan's id
#  nomer_srt  :integer		number of line
#  literatura :string(255)	contents of string
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

