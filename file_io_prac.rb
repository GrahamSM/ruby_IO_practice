require 'rubygems'
require 'rest-client'
require 'open-uri'


def open_write_site(url, local)
	File.open(local, "w") {|wiki_file| wiki_file.write(RestClient.get(url))}
end

#############
def every_fortysecond(url, local_hamlet_file)
	File.open(local_hamlet_file, "w") {|file| file.write(open(url).read)}
	File.open(local_hamlet_file, "r") do |file|
		count = 1
		file.readlines.each_with_index do |line,i|
			puts line if count % 42 == 0 || count == 1
			count += 1
		end
	end
end

#######
def only_hamlet(url, local_hamlet_file)
	File.open(local_hamlet_file, "w") {|file| file.write(open(url).read)}
	hamlet_speaking = false
	File.open(local_hamlet_file, "r") do |file| #Black to print only Hamlets lines
		file.readlines.each_with_index do |line,i|
			if line.match(/\s+Ham\..+/)
				hamlet_speaking = true
				puts line
			elsif (line.match(/^\s{4}/)) && (hamlet_speaking == true)
				puts line
			elsif line.match(/\s+\S{3}\..+/)
				hamlet_speaking = false
			end
		end
	end
end

wiki_url = "https://en.wikipedia.org/wiki/Main_Page"
wiki_local = "wiki-page.html"
open_write_site(wiki_url, wiki_local)

puts "-----------------END"

url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"
local_hamlet_file = "hamlet.txt"
every_fortysecond(url, local_hamlet_file)

puts "-----------------END"

only_hamlet(url, local_hamlet_file)