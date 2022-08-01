require_relative 'book'
require_relative 'books_controller'
require_relative 'label'
require_relative 'labels_controller'

class Main
  include BooksController
  include LabelsController

  def initialize
    @books = load_books
    @labels = load_labels
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
end
