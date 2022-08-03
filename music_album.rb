require 'json'
require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(on_spotify, publish_date, id = nil, archived: false)
    super(publish_date, id, archived: archived)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify == true
  end

  def add_music_album
    File.new('music_albums.json', 'w+') unless Dir.glob('*.json').include? 'music_albums.json'

    if File.empty?('music_albums.json')
      music_albums = []
    else
      data = File.read('music_albums.json').split
      music_albums = JSON.parse(data.join)
    end

    music_albums.push({ 'id' => @id, 'on_spotify' => @on_spotify, 'publish_date' => @publish_date,
                        'author' => @author, 'Music Label' => @label, 'Music_genre' => @genre, 'archived' => @archived })

    File.write('music_albums.json', music_albums.to_json)
  end
end
