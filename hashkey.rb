require 'time'
require 'active_support'
require 'green_shoes'
from=nil
unt=nil
haha=0
haha1=0
bool=nil
starttime=0
finishtime=0
file_=ask_open_file
Shoes.app(title:"SubtitleEditor" ) do
  if(!file_.include?".srt")
  para"losho"
      exit()
 end
  a=ask("Do you want to move all subtitles")
  if(a=="yes")
    haha=ask("Select which subtitle") 
    haha=haha.to_i
    haha1=ask("Select with how much time we are going to move finish subtitles") 
    haha1=haha1.to_i 
      bool=true
  else
    from=ask("Select from which subtitle until which subtitle you want to move")  
    from=from.to_i
    unt=ask("Until which subtitle") 
    unt=unt.to_i
     starttime=ask("Select with how much time we are going to move start subtitles") 
    starttime=starttime.to_i
    finishtime=ask("Select with how much time we are going to move finish subtitles") 
    finishtime=finishtime.to_i 
    bool=false
   end 
  File.open("#{file_}","r+") do |file|
    File.read("#{file_}").split(/^\s*$/).each do |entry| # Read in the entire text and split on empty lines
        sentence = entry.strip.split("\n")
        number = sentence[0] # First element after empty line is 'number'
        time_marker =  sentence[1]#[0..11] # Second element is 'time_marker'
        content = sentence[2..-1].join("\n") # Everything after that is 'content'
        #time_marker=time_marker.split("\s").to_i
        time_start=time_marker.split("-->").first
        time_finish=time_marker.split("-->").last
        t = Time.parse(time_start)
        t=t.usec/1000+t.sec*1000+t.min*60*1000+t.hour*60*60*1000
        p = Time.parse(time_finish)
        p=p.usec/1000+p.sec*1000+p.min*60*1000+p.hour*60*60*1000
        
        if(from <= number.to_i && unt>=number.to_i && bool==false)
          t=t/1000+starttime
          p=p/1000+finishtime
        else
           t=t/1000+haha
           p=p/1000+haha1
        end            
        time_start=Time.at(t).utc.strftime("%H:%M:%S,%3U")
       time_finish=Time.at(p).utc.strftime("%H:%M:%S,%3U")
         file.puts number
         file.puts time_start+" --> "+time_finish
         file.puts content 
         file.puts "\n"
    end
  end
   para "Wait few seconds and click X"
end
