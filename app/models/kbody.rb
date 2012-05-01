class Kbody < ActiveRecord::Base

	belongs_to :kplan

end
# == Schema Information
#
# Table name: kbodies
#
#  id             :integer         not null, primary key
#  kplan_id       :integer
#  nomer_page     :integer
#  nomer_str      :integer
#  nomer_uroka    :string(255)
#  tema_zaniatia  :string(255)
#  nomer_nedeli   :string(255)
#  kolvo_chasov   :integer
#  vid_zaniatia   :string(255)
#  nagl_posobie   :string(255)
#  zadano         :string(255)
#  samrab_casov   :string(255)
#  samrab_zadanie :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

