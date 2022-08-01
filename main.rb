require_relative 'game'

class Main 

  def user_input(message)
    print message
    gets.chomp
  end

  def start
    puts 'Welcome to your catalog of things!'
    loop do
      puts '-' * 50
      puts '
          1- List all books
          2- List all music albums
          3- List of games
          4- List all genres
          5- List all labels
          6- List all authors
          7- List all sources
          8- Add a book
          9- Add a music album
          10- Add a game
          11- Quit'

      input = user_input('Choose an option: ').to_i

      break if input == 11

      options(input)
    end
  end

  def options(input)
    case input
    when 1
      list_books
    when 2
      list_music_albums
    when 3
      list_games
    when 4
      list_genres
    when 5
      list_labels
    when 6
      list_authors
    when 7
      list_sources
    when 8
      add_book
    when 9
      add_music_album
    when 10
      add_game
    else
      puts 'Please choose a valid number!'
    end
  end

  def add_game
    multiplayer = user_input("Multiplayer: ")
    last_played = user_input('Last played at: ')
    publish_date = user_input('Publish date: ')
    Game.new(multiplayer, last_played, publish_date).add_game
    puts "The Game with #{multiplayer} as mulptiplayer has been created successfully ✅"
  end

  def list_games
    File.new('games.json', 'w+') unless Dir.glob('*.json').include? 'games.json'

    if File.empty?('games.json')
      games = []
    else
      data = File.read('games.json').split
      games = JSON.parse(data.join)
    end
     puts 'List of Games'
    games.each_with_index do |game, key|
      puts "#{key + 1}) Multiplayer: #{game['multiplayer']} Last Played: #{game['last_played_at']} Publish Date: #{game['publish_date']}"
    end
    puts ' '
  end

end

main = Main.new
main.start()
