require 'colorize'
require 'open-uri'


class Design

	def Ascii
		puts <<-'EOF'.yellow
		   _____ __         _____  __ __                  
		  / ___// /_  ___  / / / |/ // /_____  __  _______
		  \__ \/ __ \/ _ \/ / /|   // //_/ _ \/ / / / ___/
		 ___/ / / / /  __/ / //   |/ ,< /  __/ /_/ / /    
		/____/_/ /_/\___/_/_//_/|_/_/|_|\___/\__,_/_/     
                                                       
		EOF

	end

	def Copy
		puts "\t  Dev by: Muham'RB".white
		puts "\t  Script: ShellXkeur".yellow
		puts "\t  Description:".blue
		puts "\t  This script check status code of wordlist with thread".blue
	end

end

class Checker

	def initialize(file)
		@file_isset = false
		if File.file?(file)
			@file = File.readlines(file)
			@file_isset = true
		else
			@file_isset = false
		end
	end

	

	def ShellShecker(uri)
		requ = open(uri) 
		
		return requ.status
	end

	def Main
		
		i = 0
		if @file_isset == true
			noth = true
			puts "------------------Results--------------------".green
			while i < @file.size
				begin
					if self.ShellShecker(@file[i].chomp) == ["200", "OK"]
						puts "#{@file[i]} -> shell Found".green
						File.open("result.txt", "a") do |shell|
							
							shell << "#{@file[i]}"
						end
					else
						puts "#{@file[i]} -> shell not found".red
					end
				rescue
					puts "#{@file[i]} -> shell not found".red

				end
				
				i += 1

			end
			File.open("result.txt", "a") do |file|
				file.puts "------------------Result #{File.readlines("result.txt").size} shell found------------------------"
				file.close
			end
		else
			puts "File not found".red
		end
	end

end

class Main

	def help
		puts "USAGE: #{__FILE__} --wordlist <wordlist.txt>".blue
	end

	def initialize
		if ARGV.length == 2
			if ARGV[0] == ("--wordlist" || "-w")
				if ARGV[1] != nil
					design = Design.new
					design.Ascii 
					design.Copy
					puts ""
					checker = Checker.new(ARGV[1])
					checker.Main
				else
					self.help()	
				end
			elsif ARGV[0] == ("--help" || "-h")
				self.help()
			else
				self.help()
			end
		else
			self.help()	
		end
	end

end

if __FILE__ == $0
	Main.new
end
