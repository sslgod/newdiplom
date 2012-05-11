#encoding: utf-8

module ApplicationHelper
	
	def format_plan_data(data)
		data.nil? ? " " : "#{data.day} #{data_month[data.month]} #{data.year} в #{data.hour+3}.#{data.min}"
	end

	def data_month
		[' ','января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря']
	end

	def areyounil(string)
		string.nil? ? " " : string
	end

	def lib_str(plan, nom_str)
		stroka=plan.klits.where("nomer_srt=?", nom_str).first
		stroka_new=plan.klits.new(:nomer_srt=>nom_str)
		stroka.nil? ? stroka_new : stroka
	end

end
