require 'json'

module GenreContoller
    def store_genres(genres)
        file = './genres.json'
        File.new('genres.json', 'w+') unless File.exist?(file)
        data = []
        genres.each do |genre|
            data << {
                name: genre.name,
                id: genre.id
            }
        end
        File.write(file, JSON.generate(data))
    end

    def load_genres
       data = []
         file = './genres.json'
         return data unless File.exist?(file) && File.read(file) != ''
         JSON.parse(File.read(file)).each do |genre|
             data << Genre.new(genre[:name], genre[:id])
         end
            data
            end
    end