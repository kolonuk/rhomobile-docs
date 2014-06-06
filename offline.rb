require 'xmlsimple'
require 'rdiscount'
require 'rest-client'
require 'json'
class Offline
	def self.generate_json_index
	  puts "Getting MD in #{AppConfig['api_eb']}"
	  puts "Generating JSON Index: #{AppConfig['launchpad_eb']}index.json"
	  apiMD = File.join(AppConfig['api_eb'],"**","*.md")
	  apiFiles = Dir.glob(apiMD)
	  index_hash = []
	  apiFiles.each do |fileName|
	    basename = fileName.gsub(AppConfig['api_eb'],'')
	    md = File.read(fileName)
	    if md.match(/#(.*)$/).nil? 
	    	title = basename.gsub('.md','')
	    else
		    title = md.match(/#(.*)$/)[1]
	    end
		
	    puts "Processing API: #{title} in #{basename}"
	    hash_object = {
	      :name => title,
	      :md => md
	    }
	    index_hash.push hash_object    
	  end

	  guidesMD = File.join(AppConfig['guides_eb'],"**","*.md")
	  guidesFiles = Dir.glob(guidesMD)

	  guidesFiles.each do |fileName|
	    basename = fileName.gsub(AppConfig['guides_eb'],'')
	    md = File.read(fileName)
	    if md.match(/#(.*)$/).nil? 
	    	title = basename.gsub('.md','')
	    else
		    title = md.match(/#(.*)$/)[1]
	    end
		
	    puts "Processing Guide: #{title} in #{basename}"
	    hash_object = {
	      :name => title,
	      :md => md
	    }
	    index_hash.push hash_object    
	  end

	  outputfile = "#{AppConfig['api_eb']}index.json"
		File.open("#{outputfile}", 'w') {|f| 
			f.write(index_hash.to_json) 
		}

	end
end
