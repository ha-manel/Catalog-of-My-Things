require_relative '../author'

describe Author do
  it 'Should be an instance of Author' do
    author = Author.new('Azel', 'Grey')
    expect(author).to be_instance_of Author
  end

  it 'Shoud store author' do
    Author.new('Azel', 'Grey').add_author
    expect(File.exist?('authors.json') && File.read('authors.json') != '').to eq true
  end
end
