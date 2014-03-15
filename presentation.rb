require 'slide_hero'

presentation 'weekly_presentation' do
	defaults headline_size: :medium, transition: :cube
	now = Time.new
	require './code/calculations'
	xpdays = CALC.new.eol_days(now,'xp')
	k3days = CALC.new.eol_days(now,'2003')
  slide "Welcome to Security Weekly" do
  	point "#{now.strftime("%F")}"
    image "Target_fail.gif"
    point "Days till Windows XP EOL: #{xpdays}"
    point "Days till Windows 2003 EOL: #{k3days}"
	end
  slide "Security Statistics" do
   point "ITSOPS-Secuirty closed: 25"
   point "ITSOPS-Secuirty adverage age: 5"
	end
  slide "Agenda" do
    point "Disaster Recovery", animation: "grow"
    point "User Support Group", animation: "grow"
    point "Operations", animation: "grow"
    end
end
