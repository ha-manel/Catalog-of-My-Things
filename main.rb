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
end