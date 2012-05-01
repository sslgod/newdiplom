class Kplan < ActiveRecord::Base

	
	belongs_to :user
	has_many :ktitls
	has_many :klits
	has_many :kbodys


end
# == Schema Information
#
# Table name: kplans
#
#  id               :integer        id of plan   not null, primary key
#  user_id          :integer		user's id
#  predmet_comissia :integer		subject's сommission  of each plan
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

