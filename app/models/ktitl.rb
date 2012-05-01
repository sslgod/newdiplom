class Ktitl < ActiveRecord::Base
	
	belongs_to :kplan
	

end
# == Schema Information
#
# Table name: ktitls
#
#  id         :integer         not null, primary key
#  kplan_id   :integer		plans's number
#  pregmet    :string(255)	name of subject
#  spec       :string(255)	spec's name
#  group      :string(255)	name of groups
#  kurs       :string(255)	kurs
#  semestr    :string(255)	semestr
#  god        :string(255)	year
#  uchregd    :string(255)	who confirmed it
#  ch_ned     :integer		number weeks
#  ch_zan     :integer		number classes
#  ch_labrab  :integer		number labs
#  ch_kprtk   :integer		number course
#  ch_smr     :integer		number students' work
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

