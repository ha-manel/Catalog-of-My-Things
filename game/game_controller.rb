require 'json'

module GamesController
  def add_game
    multiplayer = user_input('Is the game multiplayer? [true, false]: ')
    last_played = user_input('Last played at: ')
    publish_date = user_input('Publish date: ')
    genre = Genre.new(user_input('Genre: '))
    label = Label.new(user_input('Label: '))
    author_first = user_input('Creator First Name: ')
    author_last = user_input('Creator Last Name: ')
    author = Author.new(author_first, author_last)
    new_game = Game.new(multiplayer, last_played, publish_date)
    new_game.genre = genre
    new_game.label = label
    new_game.author = author
    new_game.move_to_archive
    save_game(new_game)
    add_author(author)
    @genres << genre
    @labels << label
    puts 'The Game has been created successfully ✅'
  end

  def save_game(game)
    File.new('./game/games.json', 'w+') unless File.exist?('./game/games.json')

    if File.empty?('./game/games.json')
      games = []
    else
      data = File.read('./game/games.json').split
      games = JSON.parse(data.join)
    end

    games.push({ 'multiplayer' => game.multiplayer, 'last_played_at' => game.last_played_at,
                 'publish_date' => game.publish_date, 'genre' => game.genre,
                 'label' => game.label, 'author' => game.author })
    File.write('./game/games.json', JSON.generate(games))
  end

  def list_games
    puts '-' * 50
    File.new('./game/games.json', 'w+') unless File.exist?('./game/games.json')

    if File.empty?('./game/games.json')
      puts 'Games list is empty.'
    else
      data = File.read('./game/games.json').split
      games = JSON.parse(data.join)
      puts '🎮 Games list:'
      games.each_with_index do |game, key|
        puts "#{key + 1}-[Game] Multiplayer: #{game['multiplayer']} | " \
             "Last Played: #{game['last_played_at']} | Publish Date: #{game['publish_date']}"
      end
    end
  end
end
