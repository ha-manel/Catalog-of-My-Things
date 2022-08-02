require_relative 'game'
require_relative 'book'
require_relative 'books_controller'
require_relative 'author'
require_relative 'label'
require_relative 'labels_controller'
require_relative 'music_album'
require_relative 'genre'
require_relative 'genre_controller'

class Main
  include BooksController
  include LabelsController
  include GenreController

  def initialize
    @books = load_books
    @labels = load_labels
    @genres = load_genres
  end

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
          7- Add a book
          8- Add a music album
          9- Add a game
          10- Quit'

      input = user_input('Choose an option: ').to_i

      break if input == 10

      options(input)
    end
    store_books(@books)
    store_labels(@labels)
    store_genres(@genres)
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
      add_book
    when 8
      add_music_album
    when 9
      add_game
    else
      puts 'Please choose a valid number!'
    end
  end

  def add_game
    multiplayer = user_input('Multiplayer: ')
    last_played = user_input('Last played at: ')
    publish_date = user_input('Publish date: ')
    genre = user_input('Genre: ')
    label = user_input('Label: ')
    author_first = user_input('Author First Name: ')
    author_last = user_input('Author Last Name: ')
    new_game = Game.new(multiplayer, last_played, publish_date)
    new_game.add_game
    new_game.genre = genre
    new_game.label = label
    author = Author.new(author_first, author_last)
    new_game.author = author
    new_game.move_to_archive
    author.add_author

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
      puts "#{key + 1}) Multiplayer: #{game['multiplayer']}" \
           "Last Played: #{game['last_played_at']} Publish Date: #{game['publish_date']}"
    end
    puts ' '
  end

  def list_books
    puts '-' * 50
    if @books.empty?
      puts 'The books list is empty'
    else
      puts '📚 Books list:'
      @books.each_with_index do |book, index|
        puts "#{index + 1}-[Book] ID: #{book.id} | Publisher: #{book.publisher} |" \
             "Publish date: #{book.publish_date} | Cover state: #{book.cover_state} | Archived: #{book.archived}"
      end
    end
  end

  def add_book
    author = user_input("Book\'s author: ")
    publish_date = user_input("Book\'s publish date: ")
    publisher = user_input("Book\'s publisher: ")
    cover_state = user_input("Book\'s cover state [good, bad]: ")
    genre = user_input("Book\'s genre: ")
    label = Label.new(user_input("Book\'s label: "))
    new_book = Book.new(publish_date, publisher, cover_state)
    new_book.genre = genre
    new_book.label = label
    new_book.author = author
    new_book.move_to_archive
    @books << new_book
    @labels << label
    puts "The book (by #{author}) has been created successfully ✅"
  end

  def list_authors
    File.new('authors.json', 'w+') unless Dir.glob('*.json').include? 'authors.json'

    if File.empty?('authors.json')
      authors = []
    else
      data = File.read('authors.json').split
      authors = JSON.parse(data.join)
    end

    authors.each_with_index do |author, index|
      puts "#{index + 1}) #{author['first_name']} #{author['last_name']}"
    end
  end

  def list_labels
    puts '-' * 50
    if @labels.empty?
      puts 'The Labels list is empty'
    else
      puts '🏷️ Labels list:'
      @labels.each_with_index do |label, index|
        puts "#{index + 1}-[Label] ID: #{label.id} | Name: #{label.name}"
      end
    end
  end

  def add_music_album
    on_spotify = user_input("Music album\'s on spotify [true, false]: ")
    publish_date = user_input("Music album\'s publish date: ")
    genre = Genre.new(user_input("Album\'s genre [hiphop, classic]: "))
    label = Label.new(user_input("Album\'s label: "))
    author_first = user_input('Author First Name: ')
    author_last = user_input('Author Last Name: ')
    # author = Author.new(user_input("Album\'s singer: "))
    new_music_album = MusicAlbum.new(on_spotify, publish_date)
    author = Author.new(author_first, author_last)
    new_music_album.genre = genre
    new_music_album.label = label
    new_music_album.author = author
    new_music_album.move_to_archive
    new_music_album.add_music_album
    @labels << label
    @genres << genre
    puts 'The music album has been created successfully ✅'
  end

  def list_music_albums
    File.new('music_albums.json', 'w+') unless Dir.glob('*.json').include? 'music_albums.json'
    if File.empty?('music_albums.json')
      puts 'The music albums list is empty'
    else
      puts '🎶 Music albums list:'
      data = File.read('music_albums.json').split
      music_albums = JSON.parse(data.join)
      music_albums.each_with_index do |music_album, index|
        puts "#{index + 1}-[Music album] ID: #{music_album['id']} | On spotify: #{music_album['on_spotify']} |" \
             "Publish date: #{music_album['publish_date']} | Archived: #{music_album['archived']}"
      end
    end
  end

  def list_genres
    puts '-' * 50
    if @genres.empty?
      puts 'The genres list is empty'
    else
      puts '🎶 Genres list:'
      @genres.each_with_index do |genre, index|
        puts "#{index + 1}-[Genre] ID: #{genre.id} | Name: #{genre.name}"
      end
    end
  end
end
