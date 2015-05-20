require 'green_shoes'
 path = ask_open_folder
Shoes.app do 	
	@movies=nil
	@files=nil
	Dir.glob("#{path}/*.*").each do |movie|
		if ( movie =~ /.avi/ )
 		 @movies=File.basename(movie)
 		end	 
	end	
	if (@movies==nil)
		 para "There is no .avi files"
		exit()
	end	 
	Dir.glob("#{path}/*.srt").each do |subtitles|
		@files=subtitles
	end	
	if (@files==nil)
		 para "There is no .srt files"
		 exit()
	end
	File.rename(@files,@files.gsub(@files,@movies.gsub(".avi",".srt")))
end