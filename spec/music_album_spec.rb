require_relative '../music_album/music_album'
require_relative '../music_album/music_album_controller'

describe MusicAlbum do
  include MusicAlbumsController
  it 'Should be an instance of music_album' do
    music_album = MusicAlbum.new('test', '04-01-2010', '09-05-2017')
    expect(music_album).to be_instance_of MusicAlbum
  end

  it 'archived should be true' do
    music_album = MusicAlbum.new(true, '04-01-2010')
    music_album.move_to_archive
    music_album.archived.should eq true
  end

  it 'archived should be false' do
    music_album = MusicAlbum.new(false, '04-01-2010')
    music_album.archived.should eq false
  end

  it 'Should store MusicAlbum in json file' do
    music_album = MusicAlbum.new(true, '04-10-2020')
    save_music_album(music_album)
    expect(File.exist?('./music_album/music_albums.json') &&
           File.read('./music_album/music_albums.json') != '').to eq true
  end
end
