class CALC
	def eol_days(date,os)
	 	doy = date.strftime("%j")
	 	if os == 'xp'
	 		cutoverdate = Time.new(2014,4,8,0,0,0,"-05:00")
	 	elsif os == '2003'
	 		cutoverdate = Time.new(2015,7,14,0,0,0,"-05:00")
	 	end
	 	doco = cutoverdate.strftime("%j")
	 	yeardiff = cutoverdate.year - date.year
	 	daysleft = doco.to_i - doy.to_i
	 	daysleft + (365*yeardiff)
 	end
end