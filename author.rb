require 'json'
require_relative 'item'

class Author

	attr_accessor :id, :first_name, :last_name, :items

  def initialize(first_name, last_name)
    @id= Random.rand(1..1000)
		@first_name = first_name
		@last_name = last_name
		@items = []
	end

	def add_item(item)
    @items.push(item)
		item.author = self
	end

	def add_author
		File.new('authors.json', 'w+') unless Dir.glob('*.json').include? 'authors.json'

    if File.empty?('authors.json')
      authors = []
    else
      data = File.read('authors.json').split
      authors = JSON.parse(data.join)
    end

		authors.push({id: @id, first_name: @first_name, last_name: @last_name})
    
		File.write('authors.json', authors.to_json)
	end
end
