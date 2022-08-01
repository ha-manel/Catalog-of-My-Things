require 'json'

module BooksController
  def store_books(books)
    file = './books.json'
    File.new('books.json', 'w+') unless File.exist?(file)

    data = []

    books.each do |book|
      data << { id: book.id, publish_date: book.publish_date, publisher: book.publisher, cover_state: book.cover_state,
                archived: book.archived, genre: book.genre, author: book.author, label: book.label }
    end
    File.write(file, JSON.generate(data))
  end

  def load_books
    data = []
    file = './books.json'
    return data unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |book|
      new_book = Book.new(book['publish_date'], book['publisher'], book['cover_state'], book['id'],
                          archived: book['archived'])
      new_book.genre = book['genre']
      new_book.author = book['author']
      new_book.label = book['label']

      data << new_book
    end

    data
  end
end
