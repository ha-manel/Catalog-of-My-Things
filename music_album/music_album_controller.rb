require 'json'

module MusicAlbumsController
  def save_music_album(album)
    File.new('./music_album/music_albums.json', 'w+') unless File.exist?('./music_album/music_albums.json')

    if File.empty?('./music_album/music_albums.json')
      music_albums = []
    else
      data = File.read('./music_album/music_albums.json').split
      music_albums = JSON.parse(data.join)
    end

    music_albums.push({ 'id' => album.id, 'on_spotify' => album.on_spotify, 'publish_date' => album.publish_date,
                        'author' => album.author, 'music_label' => album.label, 'music_genre' => album.genre,
                        'archived' => album.archived })

    File.write('./music_album/music_albums.json', music_albums.to_json)
  end

  def list_music_albums
    puts '-' * 50
    File.new('./music_album/music_albums.json', 'w+') unless File.exist?('./music_album/music_albums.json')

    if File.empty?('./music_album/music_albums.json')
      puts 'The music albums list is empty'
    else
      puts '🎶  Music albums list:'
      data = File.read('./music_album/music_albums.json').split
      music_albums = JSON.parse(data.join)
      music_albums.each_with_index do |music_album, index|
        puts "#{index + 1}-[Music album] ID: #{music_album['id']} | On spotify: #{music_album['on_spotify']} | " \
             "Publish date: #{music_album['publish_date']} | Archived: #{music_album['archived']}"
      end
    end
  end

  def add_music_album
    on_spotify = user_input('Is the album on spotify? [true, false]: ')
    publish_date = user_input("Album\'s publish date: ")
    genre = Genre.new(user_input("Album\'s genre: "))
    label = Label.new(user_input("Album\'s label: "))
    author_first = user_input("Singer\'s First Name: ")
    author_last = user_input("Singer\'s Last Name: ")
    author = Author.new(author_first, author_last)
    new_music_album = MusicAlbum.new(on_spotify, publish_date)
    new_music_album.genre = genre
    new_music_album.label = label
    new_music_album.author = author
    new_music_album.move_to_archive
    save_music_album(new_music_album)
    add_author(author)
    @labels << label
    @genres << genre
    puts 'The music album has been created successfully ✅'
  end
end
