require 'xmlsimple'
require 'rdiscount'

class Apieb

@@apiName = ""

  def self.getMDDesc(desc)
  	return "#{desc}"
  	# if desc.is_a?(String)
  		# return RDiscount.new(desc, :smart).to_html
  	# else
  		# return desc
  	# end
  end
  def self.getElementName(element)
  	if !element["docNameOverride"].nil?
  		return element["docNameOverride"]
  	else
  		return element["name"]
  	end 
  end	
#returns markdown for the name of the API 
  def self.getApiName(doc,lang,allowoverride)
  	md=""
  	md = doc["MODULE"][0]["name"]
  	if allowoverride
	  	if !doc["MODULE"][0]["docNameOverride"].nil?
	  		md = doc["MODULE"][0]["docNameOverride"]
	  	else
	  		if lang == 'RUBY'
	  			md = 'Rho::' + doc["MODULE"][0]["name"]
	  		elsif lang =='JS'
	  			md = 'Rho.' + doc["MODULE"][0]["name"]
	  		else
	  			md = doc["MODULE"][0]["name"]

	  		end
	  	end
	end
  	@@apiName = md
  	return md
  end
 
  def self.getshortcut(e)
  	s = e["name"]
  	if !e["access"].nil?
  		s += e["access"]
  	end
  	return s
  end

 def self.getApiDesc(doc)
  	md=""
  	if !doc["MODULE"][0]["HELP_OVERVIEW"][0].nil? && doc["MODULE"][0]["HELP_OVERVIEW"][0].length >0

	  	md = RDiscount.new(doc["MODULE"][0]["HELP_OVERVIEW"][0], :smart).to_html
	  	if !doc["MODULE"][0]["MORE_HELP"].nil? && !doc["MODULE"][0]["MORE_HELP"][0].nil? && doc["MODULE"][0]["MORE_HELP"][0].length >0
	  		
	  		md +=RDiscount.new(doc["MODULE"][0]["MORE_HELP"][0], :smart).to_html
	  	end
  	end
  	return md
  end
 
  def self.getpropusagetext(model,property,type,ro,propbag)
  	defval = ''
  	if type == 'STRING'
  		defval = "'some string'"
  	end
  	if type == 'BOOLEAN'
  		defval = "true"
  	end
  	if type == 'INTEGER'
  		defval = "1"
  	end
  	if type == 'FLOAT'
  		defval = "1.0"
  	end
	if ro.nil?
		readonly = false
	else
		if ro=="true"
			readonly = true
		else
			readonly = false
		end
	end

  	md += "\n\n"
  	if !ro
	  	md += "\n\t// Setting directly"
	  	md += "\n\tRho.#{model}.#{property}=#{defval};"
	  	if propbag
		  	md += "\n\t// Setting one property"
		  	md += "\n\tRho.#{model}.setProperty(" + "'#{property}',#{defval});"
		  	md += "\n\t// Setting multiple properties using JSON object"
		  	md += "\n\tRho.#{model}.setProperties({ " + "'#{property}':#{defval} , 'another_property':#{defval}});"
		end
  	end 
  	if propbag
	  	md += "\n\n\t// Getting one property"
	  	md += "\n\tmyvar = Rho.#{model}.getProperty(" + "'#{property}');"
	  	md += "\n\t// Getting multiple properties"
	  	md += "\n\tmyvar = Rho.#{model}.getProperties([" + "'#{property}' , 'another_property']);"
	else
		md += "\n\n\t// Getting "
	  	md += "\n\tmyvar = Rho.#{model}.#{property};"

	end
	md += "\n\n" 
  	return md
  end





  def self.getremarks(doc)
  	md = ""
  	if !doc["MODULE"][0]["REMARKS"].nil? && !doc["MODULE"][0]["REMARKS"][0]["REMARK"].nil?
	  	s=doc["MODULE"][0]["REMARKS"][0]["REMARK"]
	  	md += "\n\n##Remarks"
	  	s.each_with_index() { |element,index|
		    md += "\n\n###" + element["title"]
		    html = getMDDesc(element["DESC"][0])
		  	md += html
	  	}

	end
	return md
  end

  def self.getconstants(doc)
  	md = ""
  	if !doc["MODULE"][0]["CONSTANTS"].nil? && !doc["MODULE"][0]["CONSTANTS"][0]["CONSTANT"].nil?
	  	s=doc["MODULE"][0]["CONSTANTS"][0]["CONSTANT"]
	  	md += '##Constants'
	  	s.each_with_index() { |element,index|
	  		element["name"] = getElementName(element) 
			md +=  "\n* " + element["name"]
			if !element["DESC"].nil? && !element["DESC"][0].is_a?(Hash)
 		        md +=  getMDDesc(element["DESC"][0])
       		end
	  	}
	end
	return md
  end


  def self.getplatformindicators (platforms,msionly,ruby,javascript,usemoduleplatforms,doc)
  	if usemoduleplatforms
  		# puts 'using platform override' + doc["MODULE"][0]["name"]
  		if !doc["MODULE"][0]["PLATFORM"][0].nil?
  			platforms = doc["MODULE"][0]["PLATFORM"][0]
  			# puts platforms
  		end

  	end
  	indicators = ""
  	if javascript
		indicators += "\n* Javascript"
	end
  	if ruby
		indicators += "\n* Ruby"
	end
	if !platforms.is_a?(Hash)
		if !platforms.downcase.index("android").nil? || !platforms.downcase.index("all").nil?
			indicators += "\n* Android"
	  	end
	  	if (!platforms.downcase.index("ios").nil? || !platforms.downcase.index("all").nil?) && !msionly
			indicators += "\n* iOS"
	  	end
	  	if !platforms.downcase.index("wm").nil? || !platforms.downcase.index("all").nil?
			indicators += "\n* Windows Embedded"
	  	end
	  	if !platforms.downcase.index("wp8").nil? || !platforms.downcase.index("all").nil?
			indicators += "\n* Windows Phone 8"
	  	end
	  	if (!platforms.downcase.index("win32").nil? || !platforms.downcase.index("all").nil?) && !msionly
			indicators += "\n* Windows Desktop"
	  	end
	  	if msionly
			indicators += "\n* Motorola Solutions Devices Only"
		end
	end	
	if indicators !=""
		indicators = "\n\n####Platforms\n" + indicators
	end
  	return indicators		
  end



  #returns Markdown for the <Properties section
def self.getparams(element,toplevel)
	# @seperator = ""
		
	# puts '***** IN GETPARAMS'
	# puts element

	methparamsdetails = ""
	methsectionparams = ""
		if !element["PARAMS"].nil?
			if !toplevel
				methsectionparams += "<ul>"
			end
			element["PARAMS"].each { |params|
				params["PARAM"].each { |param|
					param["name"] = getElementName(param) 
		
					methparamsdetailsdesc = ''
			
					# puts param
					if !param["DESC"].nil?
						methparamsdetailsdesc=getMDDesc(param["DESC"][0])
						if methparamsdetailsdesc.to_s == '{}'
							methparamsdetailsdesc= ''
						end
					end
					if !param["PLATFORM"].nil? && !toplevel
						pdesc=param["PLATFORM"][0]
						if pdesc.to_s == '{}'
							pdesc= ''
						else
							pdesc = ' Platforms:' + pdesc
						end
						methparamsdetailsdesc+=pdesc
						
					end
					
					if !param["propertyHash"].nil? && param["propertyHash"] == "true" && param["PARAMS"].nil?
						methparamsdetailsdesc += " Valid `properties` for this parameter are the properties avaliable to this API module. <a href='#Properties'>Check the property section</a>"
					end
					methparamsnil=""
					methparamsnildesc=""
					if !param["CAN_BE_NIL"].nil?
						param["CAN_BE_NIL"].each { |paramsnil|
							methparamsnil=" <span class='label label-info'>Optional</span>"
							if !paramsnil["DESC"].nil?
								methparamsnildesc =  getMDDesc(paramsnil["DESC"][0])
							end
							
						}
					end
					
					if !param["default"].nil?
						methparamsnil += "<span class='label '> Default: " + param["default"] + "</span>"
				
					end

					if param["type"].nil?
						param["type"] = "STRING"
					end
					if param["type"] == "SELF_INSTANCE"
						param["type"] = "SELF_INSTANCE: " + @@apiName
					end
					if toplevel
						
						@methparams += @seperator + '<span class="text-info">' + param["type"] + "</span> " + param["name"]
						@seperator =  ', '
					end 
					# puts param
					if param["name"].nil?
						param["name"] = ""
					end
					methparamsdetails += "<table><tr><td>" + param["name"] + "</td><td>" + param["type"] + "</td><td>" + methparamsdetailsdesc + "</td><td>" + methparamsnil + "</td></tr></table>"
					values = ""
					valuetype = param["type"]
								
					if !param["VALUES"].nil?
						values = "<dl  >"
								
						param["VALUES"].each() { |velement|
							velement["VALUE"].each() { |vaelement|
								if !vaelement["DESC"].nil?
									if !vaelement["DESC"][0].empty?
										valdesc = getMDDesc(vaelement["DESC"][0].to_s)
									else
										valdesc = ""
									end 
								end	
								if !vaelement["PLATFORM"].nil?
									if !vaelement["PLATFORM"][0].empty?
										valdesc += " Platforms: " + getMDDesc(vaelement["PLATFORM"][0].to_s)
									
									end 
								end

								@seperator = ', '
								if !vaelement["type"].nil?
									valuetype = vaelement["type"]
								end
								if !vaelement["constName"].nil?
									vaelement["value"] = 'Constant: ' + @@apiName + '.' + vaelement["constName"] + ' <br/> String:' + vaelement["value"] + ''
								end

								values += "<dt>#{vaelement["value"]}</dt><dd>#{valdesc}</dd>" 
								
							}
						

						}
						values += "</dl>"
					end
					if values != ""
						values = "<p><strong>Possible Values</strong> :</p> " + values 
					end
					
					methsectionparams += "<li>" + param["name"] + " : <span class='text-info'>" + param["type"] + "</span>#{methparamsnil}<p>" + methparamsdetailsdesc + " " + methparamsnildesc + "</p>#{values}</li>"
					methsectionparams += getparams(param,false)
				}

			}




			if !toplevel
				methsectionparams += "</ul>"
			end
			
			
		end

		if !element["PARAM"].nil?
			if !toplevel
				methsectionparams += "<ul>"
			end
				element["PARAM"].each { |param|
					param["name"] = getElementName(param) 
		
					methparamsdetailsdesc = ''
			
					# puts param
					if !param["DESC"].nil?
						methparamsdetailsdesc=getMDDesc(param["DESC"][0])
						if methparamsdetailsdesc.to_s == '{}'
							methparamsdetailsdesc= ''
						end
					end
					

					

					methparamsnil=""
					methparamsnildesc=""
					if !param["CAN_BE_NIL"].nil?
						param["CAN_BE_NIL"].each { |paramsnil|
							methparamsnil=" <span class='label label-info'>Optional</span>"
							if !paramsnil["DESC"].nil?
								methparamsnildesc =  getMDDesc(paramsnil["DESC"][0])
							end
							
						}
					end
					if !param["default"].nil?
						methparamsnil += " <span class='label '> Default: " + param["default"] + "</span>"
				
					end
					
					if param["type"].nil?
						param["type"] = "STRING"
					end
					if param["type"] == "SELF_INSTANCE"
						param["type"] = "SELF_INSTANCE: " + @@apiName
					end

					if param["name"].nil?
						param["name"] = "<i>Object</i>"
					end

					# puts param
					if param["name"].nil?
						param["name"] = ""
					end
					methparamsdetails += "<table><tr><td>" + param["name"] + "</td><td>" + param["type"] + "</td><td>" + methparamsdetailsdesc + "</td><td>" + methparamsnil + "</td></tr></table>"
					values = ""
					valuetype = param["type"]
								
					if !param["VALUES"].nil?
						param["VALUES"].each() { |velement|
							velement["VALUE"].each() { |vaelement|
								valdesc = "<dl  >"
								if !vaelement["DESC"].nil?
									if !vaelement["DESC"][0].empty?
										valdesc = getMDDesc(vaelement["DESC"][0].to_s)
									else
										valdesc = ""
									end 
								end	
								if !vaelement["PLATFORM"].nil?
									if !vaelement["PLATFORM"][0].empty?
										valdesc += " Platforms: " + getMDDesc(vaelement["PLATFORM"][0].to_s)
									
									end 
								end								
								@seperator = ', '
								if !vaelement["type"].nil?
									valuetype = vaelement["type"]
								end
								if !vaelement["constName"].nil?
									vaelement["value"] = 'Constant: ' + @@apiName + '.' + vaelement["constName"] + ' <br/> String: ' + vaelement["value"] + ' '
								end

								values += "<dt>#{vaelement["value"]}</dt><dd>#{valdesc}</dd>" 
								
							}
						values += "</dl>"

						}
					end
					if values != ""
						values = "<p><strong>Possible Values</strong> :</p> " + values 
					end
					
					methsectionparams += "<li>" + param["name"] + " : <span class='text-info'>" + param["type"] + "</span>#{methparamsnil}<p>" + methparamsdetailsdesc + " " + methparamsnildesc + "</p>#{values}</li>"
					methsectionparams += getparams(param,false)
				}

			



			
			if !toplevel
				methsectionparams += "</ul>"
			end
			
			
		end

	return methsectionparams
end

#returns Markdown for the <Properties section
  def self.getmethods(doc)
  	#puts "********************* METHODS *************"
	#puts doc["MODULE"][0]["METHODS"][0]
  	md = ""

  	
  	@methsectionparams= ""
  	s=doc["MODULE"][0]["METHODS"][0]["METHOD"].sort {|x,y| x["name"] <=> y["name"]} rescue {}
    
    #puts methodaliases
		
	s.each() { |element|
		element["name"] = getElementName(element) 
		if element["generateDoc"].nil? || element["generateDoc"] == "true"
			methname = element["name"]

			if !element["DESC"].nil? && !element["DESC"][0].is_a?(Hash) 
				@methdesc = getMDDesc(element["DESC"][0])
				
			else
				@methdesc = ""
			end

			@methparams = ""
			@methparamsdetails = ""
			@methsectionparams = ""
			@theCallbackElement = nil
			@seperator = ""
			
			# ****** PARAMS LISTING SECTION
			if !element["PARAMS"].nil? || (@methhascallback !="" && @methhascallback != "none")
				@methsectionparams = "\n\n"
				@methsectionparams += "####Parameters"
				@methsectionparams += "\n<ul>"
			
				@methsectionparams += getparams(element,true)
			#add generic syntax for callback param
				if @methhascallback !="" && @methhascallback != "none"
					 # puts element["CALLBACK"]
					
					@methcallbackoptional= ""
					if @methhascallback == "optional"
						@methcallbackoptional = " <span class='label label-info'>Optional</span> "
					end
					if @methhascallback == "mandatory"
						@methcallbackoptional = " <span class='label label-warning'>Mandatory</span> "
					end
					firstcallbackreturnparam = "calbackreturnparamname"
					callbacktype = "CallBackHandler"
					callbackreturntype = ""
					
					if !element["CALLBACK"].nil?
						@theCallbackElement = element["CALLBACK"]
					else
						@theCallbackElement = element["RETURN"]
					end

					 # puts @theCallbackElement
					
					if !@theCallbackElement.nil? && !@theCallbackElement[0]["type"].nil?
					
						callbackreturntype = @theCallbackElement[0]["type"]
					else
						callbackreturntype = "OBJECT"
					end
					if !@theCallbackElement.nil? && !@theCallbackElement[0]["PARAMS"].nil?
						# puts @theCallbackElement[0]["PARAMS"]
						firstcallbackreturnparam = @theCallbackElement[0]["PARAMS"][0]["PARAM"][0]["name"]
					end
					if !element["PARAMS"].nil?
						prevparams = "...,"
					else
						prevparams = ""
					end
					@methsectionparams += "<li>callback : <span class='text-info'>#{callbacktype}</span>#{@methcallbackoptional}</li>"

	  			end
	  			@methsectionparams += "</ul>"
				
	  		end

	  		# **** CALLBACK SECTION 
	  		@methsectioncallbackparams = ""
	  		if @methhascallback !="" && @methhascallback != "none"
				@methcallbackdetails = ""
				if !@theCallbackElement.nil? && !@theCallbackElement[0].nil?
					@methsectioncallbackparams = "\n\n####Callback"
					@methsectioncallbackparams += "\nAsync Callback Returning Parameters: <span class='text-info'>#{callbackreturntype}</span></p><ul>"
					@methsectioncallbackparams += getparams(@theCallbackElement[0],false)
					@methsectioncallbackparams += "</ul>"
				end  			

	  		end

	  		# ***** RETURN SECTION
			@methreturn = "Void"
			@methreturndesc=""
			methreturnparams = ""
			if !element["RETURN"].nil?
				element["RETURN"].each() { |relement|
					if relement["type"].nil? || relement["type"]==''
						@methreturn="Void"
					else
						@methreturn = relement["type"]
					end	
					
					# puts relement
			
					if !relement["DESC"].nil? && !relement["DESC"][0].is_a?(Hash)
						@methreturndesc=" : " + getMDDesc(relement["DESC"][0])
					end
					methreturnparams =  getparams(relement,false)
				}
			end	  		
			@methsectionreturns = "\n\n####Returns"
			@methsectionreturns += "\nSynchronous Return:<ul>"
			@methsectionreturns += "<li>#{@methreturn}#{@methreturndesc}#{methreturnparams}</li></ul>"

			# *** PLATFORMS SECTION
			@methplatforms = "All"
			@usemoduleplatforms = false
			msionly = false
			ruby = true
			javascript = true
			if !element["APPLIES"].nil? 

				appliescontent = ""
				# puts element["APPLIES"]
				if !element["APPLIES"][0]["msiOnly"].nil?
					if element["APPLIES"][0]["msiOnly"] == "true"
						msionly = true
					end
				end
				if !element["APPLIES"][0]["rubyOnly"].nil?
					if element["APPLIES"][0]["rubyOnly"] == "true"
						javascript = false
					end
				end
				if !element["APPLIES"][0]["jsOnly"].nil?
					if element["APPLIES"][0]["jsOnly"] == "true"
						ruby = false
					end
				end
				if !element["APPLIES"][0]["content"].nil?
					appliescontent = element["APPLIES"][0]["content"]	
				end	
				if appliescontent.size >0
					
					methnote= "(" + appliescontent + ")"
				end

			end			
			if !element["PLATFORM"].nil?
				@methplatforms = element["PLATFORM"][0]
				if !element["PLATFORM"][0]["usemodule"].nil?
					@usemoduleplatforms = true
				end

			else
				puts "      #{methname} no platform indicators"
				@usemoduleplatforms = true
				
			end			
			@methplatforms = getplatformindicators(@methplatforms,msionly,ruby,javascript,@usemoduleplatforms,doc)
		

			# *** ACCESS SECTION

			templateDefault = false
			  	if !doc["MODULE"][0]["TEMPLATES"].nil? && !doc["MODULE"][0]["TEMPLATES"][0].nil? && !doc["MODULE"][0]["TEMPLATES"][0]["DEFAULT_INSTANCE"].nil?
			  		templateDefault = true
			  	end
			if element["access"].nil? && element["scopeOverride"].nil?
					#use global PROPERTIES field
					masterAccess = doc["MODULE"][0]["METHODS"][0]["access"]
			else
					if !element["scopeOverride"].nil?
						masterAccess = element["scopeOverride"]
					else
						masterAccess = element["access"]
					end

			end			
			constructor = false
		  	constructorLabel = ''
		  	if !element["constructor"].nil?
				if element["constructor"] == "true"
				    constructor = true
				    constructorLabel = '<span class="label label-inverse"> Constructor</span> '
				end
		  	end
		  	destructor = false
		  	destructorLabel = ''
		  	if !element["destructor"].nil?
				if element["destructor"] == "true"
				    destructor = true
				    destructorLabel = '<span class="label label-inverse"> Destructor</span> '
				end
		  	end
			if masterAccess.nil? || masterAccess == 'INSTANCE' || masterAccess == ''
				accesstype = '<li><i class="icon-file"></i>Instance Method: This method can be accessed via an instance object of this class: <ul><li><code>myObject.' + element["name"] + "(#{@methparams})</code></li></ul></li>"
				if templateDefault
				accesstype += '<li><i class="icon-file"></i>Default Instance: This method can be accessed via the default instance object of this class. <ul>'
				if javascript 
					accesstype += '<li><code>' + getApiName(doc,'JS',true) + '.' + element["name"] + "(#{@methparams})</code> </li>"
				end
				accesstype += '</ul></li>'

				end 
			else
				accesstype = '<li><i class="icon-book"></i>Class Method: This method can only be accessed via the API class object. <ul>'
				if javascript 
					accesstype += '<li><code>' + getApiName(doc,'JS',true) + '.' + element["name"] + "(#{@methparams})</code> </li>"
				end
				accesstype += '</ul></li>'

			end	
			if constructor
				accesstype = '<li>Class Method: This method is a constructor and can only be accessed via the `new` construct. <ul>'
				if javascript 
					accesstype += '<li><code>var myObj = new ' + getApiName(doc,'JS',true) + "(#{@methparams})</code> </li>"
				end
				accesstype += '</ul></li>'
			end
			if destructor
				accesstype = '<li>Class Method: This method is a destructor and can only be accessed via the object that was created by the `new` constructor. <ul>'
				if javascript 
					accesstype += '<li><code>myObj.' +  element["name"]  +  "(#{@methparams})</code> </li>"
				end
				accesstype += '</ul></li>'
			end
			@methsectionaccess = "\n\n####Method Access:\n<ul>#{accesstype}</ul>"			

			# *** BUILD ORDER OF SECTIONS
		  	if constructor
			    md += "\n\n### #{constructorLabel} new " + @@apiName +  "(#{@methparams})"
		  	else
			    md += "\n\n### #{destructorLabel}" + methname + "(#{@methparams})"
		  	end

		    md += @methdesc 
		    if @methsectionparams != ''
    			md += @methsectionparams
    		end
		    if @methsectioncallbackparams != ''
    			md += @methsectioncallbackparams
    		end
		    if @methsectionreturns != ''
    			md += @methsectionreturns
    		end
    		if @methplatforms != ''
    			md += @methplatforms
    		end
    		if @methsectionaccess != ''
    			md += @methsectionaccess
    		end

		end 
  	}

  	return md
  end

def self.getproperties(doc)
	md = ""
	generateAccessors = true

	templatePropBag = false
  	if !doc["MODULE"][0]["TEMPLATES"].nil? && !doc["MODULE"][0]["TEMPLATES"][0].nil? && !doc["MODULE"][0]["TEMPLATES"][0]["PROPERTY_BAG"].nil?
  		templatePropBag = true
  	end

	if !doc["MODULE"][0]["TEMPLATES"].nil? && doc["MODULE"][0]["TEMPLATES"][0]["PROPERTY_BAG"].nil?
		templatePropBag = false
	end
	if !doc["MODULE"][0]["PROPERTIES"].nil? && !doc["MODULE"][0]["PROPERTIES"][0]["generateAccessors"].nil? && doc["MODULE"][0]["PROPERTIES"][0]["generateAccessors"] == "false"
		generateAccessors = false
	end
	if !doc["MODULE"][0]["PROPERTIES"].nil? && !doc["MODULE"][0]["PROPERTIES"][0]["PROPERTY"].nil?
		s=doc["MODULE"][0]["PROPERTIES"][0]["PROPERTY"].sort {|x,y| x["name"] <=> y["name"]}

		s.each() { |element|
			element["name"] = getElementName(element) 
		
			if element["generateDoc"].nil? || element["generateDoc"] == "true"

				propname = element["name"]
				propusage = ""
				propver = ""
				propnote = ""
				# type is optional default is STRING
				 #puts element
				if !element["VER_INTRODUCED"].nil?
					propver= "<span class='muted pull-right'>" + element["VER_INTRODUCED"][0] + "</span>"
					
				end
				msionly = false
				ruby = true
				javascript = true
		
				if !element["APPLIES"].nil? 
					appliescontent = ""
					# puts element["APPLIES"]
					if !element["APPLIES"][0]["msiOnly"].nil?
						if element["APPLIES"][0]["msiOnly"] == "true"
							msionly = true
						end
					end
					if !element["APPLIES"][0]["rubyOnly"].nil?
						if element["APPLIES"][0]["rubyOnly"] == "true"
							javascript = false
						end
					end
					if !element["APPLIES"][0]["jsOnly"].nil?
						if element["APPLIES"][0]["jsOnly"] == "true"
							ruby = false
						end
					end
					if !element["APPLIES"][0]["content"].nil?
						appliescontent = element["APPLIES"][0]["content"]	
					end	
					if appliescontent.size >0
						propnote= "(" + appliescontent + ")"
					end
				end
				@propplatforms = "All"
				@usemoduleplatforms = false
				if !element["PLATFORM"].nil?
					@propplatforms = element["PLATFORM"][0]
					if !element["PLATFORM"][0]["usemodule"].nil?
						@usemoduleplatforms = true
					end
				else
					puts "      #{propname} no platform indicators"
					@usemoduleplatforms = true
				end
				@propplatforms = getplatformindicators(@propplatforms,msionly,ruby,javascript,@usemoduleplatforms,doc)
				@propsectionplatforms = ""
				if element["type"].nil?
					proptype= "<span class='text-info'>STRING</span>"
				else
					proptype= "<span class='text-info'>" + element["type"] + "</span>"
				end			
			
				# readOnly is optional default is false
				if element["readOnly"].nil?
					propreadOnly= ""
				else
					propreadOnly= element["readOnly"]
					if propreadOnly=="true"
						propreadOnly="<span class='label'>Read Only</span>"
					else
						propreadOnly=""
					end
				end
			
				if element["default"].nil? 
					propdefault= ""
				else
					
					propdefault= "<p><strong>Default:</strong> " + element["default"] + "</p>"
					if propdefault == "<p><strong>Default:</strong> </p>"
						propdefault=""
					end
					
				end
			
				@propdesc = getMDDesc(element["DESC"][0])
				#if @propdesc.nil?
				#	RDiscount.new(@propdesc, :smart).to_html
				#end

				@propvalues = ""
				@propvaluetype = "STRING" #STRING IS DEFAULT IF NO TYPE SPECIFIED FOR propvalue
				@seperator = ""
				if !element["VALUES"].nil?
					@propvalues = ""
					element["VALUES"].each() { |velement|

						velement["VALUE"].each() { |vaelement|
							@propvaldesc = ""
							if !vaelement["DESC"].nil?
								if !vaelement["DESC"][0].empty?
									@propvaldesc = getMDDesc(vaelement["DESC"][0].to_s)
								else
									@propvaldesc = ""
								end 
							end	
							if !vaelement["PLATFORM"].nil?
								if !vaelement["PLATFORM"][0].empty?
									@propvaldesc += "Platforms: " + getMDDesc(vaelement["PLATFORM"][0].to_s)
								
								end 
							end
							@seperator = ', '
							if !vaelement["type"].nil?
								@propvaluetype = !vaelement["type"]
							end
							if !vaelement["constName"].nil?
								vaelement["value"] = "Constant: " + @@apiName + '.' + vaelement["constName"] + " \n\t* String: " + vaelement["value"] 

							end
							@propvalues += "\n* #{vaelement["value"]}\n\t* #{@propvaldesc}" 
							
						}
					@propvalues += ""

					}
				end
				if @propvalues != ""
					@propvalues = "\n<strong>Possible Values</strong> (<span class='text-info'>#{@propvaluetype}</span>):\n " + @propvalues 
				end
				propreplaces = ""

				#Check to see if need to add to description about this method replacing a deprecated one
				if !doc["MODULE"][0]["PROPERTIES"].nil? && !doc["MODULE"][0]["PROPERTIES"][0]["ALIASES"].nil?  && !doc["MODULE"][0]["PROPERTIES"][0]["ALIASES"][0].empty?
			    	doc["MODULE"][0]["PROPERTIES"][0]["ALIASES"][0]["ALIAS"].each() { |a|
						#puts a
						if a["existing"] == element["name"]
							propreplaces += a["new"]
						end
					}
				end
				propdisplayname = propname
				deprecated = ""
				if !element["deprecated"].nil?
					deprecated = element["deprecated"]
				end

				if propreplaces != ""
					propdisplayname = '<span class="text-info">' + propname + '</span>'
					@propdesc = "<span class='label label-info'>Replaces:#{propreplaces}</span> " + @propdesc

				end
				if deprecated != ""
						propdisplayname = '<span class="text-error">' + propname + '</span>'
						@propdesc = "<span class='label label-important'>Deprecated</span> " + @propdesc
				end
				templateDefault = false
			  	if !doc["MODULE"][0]["TEMPLATES"].nil? && !doc["MODULE"][0]["TEMPLATES"][0].nil? && !doc["MODULE"][0]["TEMPLATES"][0]["DEFAULT_INSTANCE"].nil?
			  		templateDefault = true
			  	end
				if element["access"].nil? && element["scopeOverride"].nil?
						#use global PROPERTIES field
						masterAccess = doc["MODULE"][0]["PROPERTIES"][0]["access"]
				else
						if !element["scopeOverride"].nil?
							masterAccess = element["scopeOverride"]
						else
							masterAccess = element["access"]
						end
				end
				if masterAccess.nil? || masterAccess == 'INSTANCE' || masterAccess == ''
					accesstype = '<li><i class="icon-file"></i>Instance: This property can be accessed via an instance object of this class: <ul><li><code>myObject.' + element["name"] + '</code></li></ul></li>'
					if templateDefault
						accesstype += '<li><i class="icon-file"></i>Default Instance: This property can be accessed via the default instance object of this class. <ul>'
						if javascript 
							accesstype += '<li><code>' + getApiName(doc,'JS',true) + '.' + element["name"] + '</code> </li>'
						end
						accesstype += '</ul></li>'

					end 
				else
					accesstype = '<li><i class="icon-book"></i>Class: This property can only be accessed via the API class object. <ul>'
					if javascript
						accesstype +='<li><code>' + getApiName(doc,'JS',true) + '.' + element["name"] + '</code> </li>'
					end
					accesstype +='</ul></li>'
				end	
				@propsectionaccess = "<ul>#{accesstype}</ul>"

				propParasDef = getparams(element,true) + propdefault
				if !generateAccessors
					@propsectionaccess += "\nThis property cannot be accessed via setter or getter methods. It can be used in methods that allow a HASH or Array of properties to be passed in."
				end
				md += "\n\n###" + propdisplayname 
				md += "\n\n####Type" 
				md += "\n#{proptype} #{propreadOnly}"
				md += "\n####Description"
				md += "\n#{@propdesc}"
				if propParasDef != ''
					md += "\n####Params"
					md += "\n#{propParasDef}"
				end
				if @propvalues != ''
					md += "\n####Values"
					md += "\n#{@propvalues}"
				end
				if @propsectionaccess != ''
					md += "\n####Access"
					md += "\n#{@propsectionaccess}"
				end
				if @propsectionplatforms != ''
					md += "\n#{@propsectionplatforms}#{propnote}"
				end
			end
	  	}
	end
	return md
end




  def self.markdown(topic)
    md = ''

  	# xml = File.read(topic)
  	# doc = REXML::Document.new xml
  	
  	# puts topic
  	doc = XmlSimple.xml_in(topic)
  	if doc["MODULE"][0]["generateDoc"].nil? || doc["MODULE"][0]["generateDoc"] == "true"
	  	templatePropBag = false
	  	if !doc["MODULE"][0]["TEMPLATES"].nil? && !doc["MODULE"][0]["TEMPLATES"][0].nil? && !doc["MODULE"][0]["TEMPLATES"][0]["PROPERTY_BAG"].nil?
	  		templatePropBag = true
	  	end
	  	templateDefault = false
	  	if !doc["MODULE"][0]["TEMPLATES"].nil? && !doc["MODULE"][0]["TEMPLATES"][0].nil? && !doc["MODULE"][0]["TEMPLATES"][0]["DEFAULT_INSTANCE"].nil?
	  		templateDefault = true
	  	end
	  	templateSingleton = false
	  	if !doc["MODULE"][0]["TEMPLATES"].nil? && !doc["MODULE"][0]["TEMPLATES"][0].nil? && !doc["MODULE"][0]["TEMPLATES"][0]["SINGLETON_INSTANCES"].nil?
	  		templateSingleton = true
	  	end
	  	# Add template methods,properties,constants
	  	if !doc["MODULE"][0]["TEMPLATES"].nil? && !doc["MODULE"][0]["TEMPLATES"][0].nil? && !doc["MODULE"][0]["TEMPLATES"][0]["INCLUDE"].nil?
	  		
	  		puts 'Has a template' 
	  		puts doc["MODULE"][0]["TEMPLATES"][0]["INCLUDE"]
	  		templateFileString = doc["MODULE"][0]["TEMPLATES"][0]["INCLUDE"][0]["path"]
	  		w = templateFileString.split("/")
	  		templateFile = w[w.length() - 1]
	  		templatedoc = XmlSimple.xml_in(File.join(AppConfig['api_eb'],templateFile))
			templatedoc["MODULE"][0]["METHODS"][0]["METHOD"].each { |m|
				doc["MODULE"][0]["METHODS"][0]["METHOD"].push(m)
			}
			# puts(doc)
			if doc["MODULE"][0]["PROPERTIES"].nil?
				doc["MODULE"][0]["PROPERTIES"] = templatedoc["MODULE"][0]["PROPERTIES"]
			else
				templatedoc["MODULE"][0]["PROPERTIES"][0]["PROPERTY"].each { |m|
					doc["MODULE"][0]["PROPERTIES"][0]["PROPERTY"].push(m)
				}

			end
			puts (doc["MODULE"][0]["PROPERTIES"])
			templatedoc["MODULE"][0]["CONSTANTS"][0]["CONSTANT"].each { |m|
				doc["MODULE"][0]["CONSTANTS"][0]["CONSTANT"].push(m)
			}
	  	end
	  	if templateDefault
	  		#get xml from file and put it in main array so it is handled like other methods
	  		defaultdoc = XmlSimple.xml_in(File.join(AppConfig['api_eb'],'default_instance.xml'))
			defaultdoc["METHODS"][0]["METHOD"].each { |m|
				doc["MODULE"][0]["METHODS"][0]["METHOD"].push(m)
			}
	  	end
	  	if templateSingleton
	  		#get xml from file and put it in main array so it is handled like other methods
	  		puts topic + 'trying to use singleton'
	  		# This was commented out as engineering changed their minds on singleton usage no longer used
	  		# it use to be just enumerate, but now that is in indicidual api docs

	  		# singletondoc = XmlSimple.xml_in('docs/api/singleton_instances.xml')
			# singletondoc["METHODS"][0]["METHOD"].each { |m|
				# doc["MODULE"][0]["METHODS"][0]["METHOD"].push(m)
			# }
	  	end
	  	if templatePropBag
	  		#get xml from file and put it in main array so it is handled like other methods
	  		propbagdoc = XmlSimple.xml_in(File.join(AppConfig['api_eb'],'property_bag.xml'))
			propbagdoc["METHODS"][0]["METHOD"].each { |m|
				doc["MODULE"][0]["METHODS"][0]["METHOD"].push(m)
			}
	  	end
	  	#get api name from <MODULE name="" ...
	  	# need to figure out what to do if multiple <MODULE tags in one physical file
	  	#puts doc

	  	docmethods = getmethods(doc)
	  	docproperties = getproperties(doc)
	  	

	  	md += "#" + getApiName(doc,'',true) + "\n" 
	  	md += "\n\n## Overview" 
	  	md += "\n" + getApiDesc(doc) + "\n" 
	  	
	  	if docmethods !=""
		  	md += "\n\n##Methods" + "\n\n" 
		  	md += docmethods
		end
		if docproperties !=""
		  	md += "\n\n##Properties" + "\n\n" 
		  	md += docproperties
		end

	  	# puts md
	  	File.open("#{topic.gsub!('.xml','.md')}", 'w') {|f| f.write(md) }
	else
		puts ('Skipping Undocumented API: ' + doc["MODULE"][0]["name"] )
	end
  return md
  end

end
