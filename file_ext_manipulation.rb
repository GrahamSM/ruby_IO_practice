require 'pp'


def extension_spread(dirname, extensions_hash)
	Dir.glob("#{dirname}/**/*.*") do |fname|
		fname.match(/(\.[a-z]+)/)
		if extensions_hash[$1.to_sym] == nil
			extensions_hash[$1.to_sym] = []
			extensions_hash[$1.to_sym] << 1
			extensions_hash[$1.to_sym] << File.size(fname)
		else
			extensions_hash[$1.to_sym][0] += 1
			extensions_hash[$1.to_sym][1] += File.size(fname)
		end
	end
end

def display_spread(extensions_hash)
	extensions_hash.each do |ext, arr|
		puts "#{ext}\t#{arr[0]}\t#{arr[1]} bytes"
	end
end

def ten_largest(dirname)
	Dir.glob("#{dirname}/**/*.*").sort_by{|fname| File.size(fname)}.reverse[0..9].each do |fname|
		puts "#{fname} #{File.size(fname)}"
	end
end


####################################

dirname = "/Users/GrahamSM/lighthouse"
extensions_hash = {}

extension_spread(dirname, extensions_hash)
display_spread(extensions_hash)
ten_largest(dirname)




