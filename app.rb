require 'rubygems'
require 'sinatra'

set :haml, :format => :html5

configure do
	set :datafile, 'us-uk-films.txt'
end

helpers do

	def get_movie
		File.readlines(settings.datafile).sample
	end

	def make_password(string)
		words = string.split(" ").select { |v| v=~ /[A-Za-z]{5,}/ }
		if words.count == 2
			return words[0].downcase.gsub(/[^a-z\s]/, '').capitalize + Random.rand(101..999).to_s + words[1].downcase.gsub(/[^a-z\s]/, '').capitalize
		else
			redirect "/"
		end
	end

end

get '/' do
  @movie = get_movie
  haml :index
end