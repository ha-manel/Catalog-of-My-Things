require_relative '../book'
require_relative '../books_controller'
require 'yaml'

describe Book do
  include BooksController

  it 'archived should be true' do
    book = Book.new('20/10/2010', 'publisher', 'good')
    book.move_to_archive
    book.archived.should eq true
  end

  it 'archived should be true' do
    book = Book.new('20/10/2020', 'publisher', 'bad')
    book.move_to_archive
    book.archived.should eq true
  end

  it 'archived should be false' do
    book = Book.new('20/10/2020', 'publisher', 'good')
    book.move_to_archive
    book.archived.should eq false
  end

  it 'should store books' do
    books = [Book.new('20/10/2020', 'publisher', 'good'), Book.new('10/2/2021', 'publisher', 'bad')]
    store_books(books)
    expect(File.exist?('books.json') && File.read('books.json') != '').to eq true
  end

  it 'should load books' do
    books = load_books
    expect(books.length).to eq 2
  end
end
