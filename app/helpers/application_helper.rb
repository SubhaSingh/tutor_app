module ApplicationHelper\

	#Returns the full title if page title not provided
	def full_title(page_title = '')
		base_title = "Tutor Management App"
		if page_title.empty?
			base_title
		else 
			page_title + " | " + base_title
		end
	end
end
