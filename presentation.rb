require 'slide_hero'

presentation 'Security Weekly Presentation' do
	defaults headline_size: :medium, transition: :cube
	now = Time.new
	require './code/calculations'
	require './code/sn_do'

	xpdays = CALC.new.eol_days(now,'xp')
	k3days = CALC.new.eol_days(now,'2003')
	#this is sooo messy
	assign_group_id = '8a4dde73c6112278017a6a4baf547aa7'
	assignment_group = 'ITSOPS-Secuirty'
	SN_DO::INC.new('demo017','admin','admin')
	httpresult = SN_DO::INC.retrieve('XML','assignment_group', assign_group_id)
	incident_list = SN_DO::INC.parse_xml(httpresult)
	total_incidents = incident_list.count
	filtered_incidents = SN_DO::INC.filter(incident_list, 'out', 'incident_state', '1')
	openedlast_24 = SN_DO::INC.count_datediff(incident_list,'opened','less',1)
	olderthen7days = SN_DO::INC.count_datediff(incident_list,'opened','more',7)
	notupdated7days = SN_DO::INC.count_datediff(incident_list,'updated','more',7)
	notupdated7days_details = SN_DO::INC.details_datediff(incident_list,'updated','more',7)
	notupdated7days_details.each do |inc|
		SN_DO::INC.gen_url(sys_id)
	  	link = SN_DO::INC.gen_url(inc[:sys_id])
	  	inc[:url] = link
	  end
	  if notupdated7days_details.any?
	   	info = "<b>Details on Incidents not updated for 7 days</b>\n<br>"
	   	notupdated7days_details.each do |inc|
	   		info << %Q^Number: <a href="#{inc[:url]}">#{inc[:number]}</a> Priority: #{inc[:priority]} Updated_by: #{inc[:updated_by]} Desc: #{inc[:short_desc]}\n<br>^
	   	end
	  end
 grouped_slides do
  slide "Welcome to Security Weekly" do
  	point "#{now.strftime("%F")}"
    image "Target_fail.gif"
    point "Days till Windows XP EOL: #{xpdays}"
    point "Days till Windows 2003 EOL: #{k3days}"
	end
  slide "Target Hack" do
   point "Dedicated NOC and SOC in Bangalore"
   point "$1.6 Million spent on FireEye" 
   point "HVAC vendors credentials compromised", animation: "highlight-red"
   point "Hackers used SCCM type software to distribute malware", animation: "highlight-red"
   point "FireEye alerts of exfiltration malware trip"
   point "NOC escalates alert to SOC"
   point "SEP even alerts to suspicious behavior"
   point "SOC dosen't investigate the alerts", animation: "highlight-red"
   point "40 Million credit cards stolen"
   point "Everyone says 'our IT system and security measures are in full compliance with industry practices'", animation: "grow"
   	end
 end #group end

 grouped_slides do
  slide "Statistics" do 
   point "#{assignment_group} total incidents: #{total_incidents}"
   point "#{assignment_group} incidents last 24hrs: #{openedlast_24}"
  end
  slide "Details" do
  	point "#{info}"
  end
end

  slide "Agenda" do
    point "Disaster Recovery", animation: "grow"
    point "User Support Group", animation: "grow"
    point "Operations", animation: "grow"
    point "Compliance", animation: "grow"
    list do 
    	point "oh snap", animation: "grow"
    end
    end
end