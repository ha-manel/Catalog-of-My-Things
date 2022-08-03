require_relative '../music_album'

describe MusicAlbum do
  it 'Should be an instance of music_album' do
    music_album = MusicAlbum.new('test', '04-01-2010', '09-05-2017',)
    expect(music_album).to be_instance_of MusicAlbum
  end

  it 'archived should be true' do
    music_album = MusicAlbum.new('test', '04-01-2010', '09-05-2017', archived: true)
    music_album.move_to_archive
    music_album.archived.should eq true
  end

  it 'archived should be true' do
    music_album = MusicAlbum.new('test', '04-01-2010', '09-05-2017', archived: false)
    music_album.archived.should eq false
  end

  it 'Should store MusicAlbum in json file' do
    music_album = MusicAlbum.new('test', '04-10-2020', 'test')
    music_album.add_music_album
    expect(File.exist?('music_albums.json') && File.read('music_albums.json') != '').to eq true
  end
end
