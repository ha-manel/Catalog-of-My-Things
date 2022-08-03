require_relative '../genre/genre'
require_relative '../genre/genre_controller'
require_relative '../music_album/music_album'

describe Genre do
  include GenresController
  it 'item should be added to array' do
    genre = Genre.new('genre')
    music_album = MusicAlbum.new('test', '20/10/2010', 'test')
    genre.add_item(music_album)
    expect(genre.items).to contain_exactly(music_album)
  end

  it 'should store genres' do
    genres = [Genre.new('test1'), Genre.new('test2')]
    store_genres(genres)
    expect(File.exist?('./genre/genres.json') && File.read('./genre/genres.json') != '').to eq true
  end
end
