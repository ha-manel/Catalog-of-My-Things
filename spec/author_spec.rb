require_relative '.././author/author'
require_relative '.././author/author_controller'

describe Author do
  include AuthorsController
  it 'Should be an instance of Author' do
    author = Author.new('Azel', 'Grey')
    expect(author).to be_instance_of Author
  end

  it 'Shoud store author' do
    add_author(Author.new('Azel', 'Grey'))
    expect(File.exist?('./author/authors.json') && File.read('./author/authors.json') != '').to eq true
    File.write('./author/authors.json', '')
  end
end
