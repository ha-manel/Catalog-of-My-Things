require 'json'
require 'date'
require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at, :publish_date

  def initialize(multiplayer, last_played_at, publish_date, id = nil, archived: false)
    super(publish_date, id, archived: archived)
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at)
    @publish_date = publish_date
  end

  def can_be_archived?
    (Date.today.year - @last_played_at.year) > 2
  end

  def add_game
    File.new('games.json', 'w+') unless Dir.glob('*.json').include? 'games.json'

    if File.empty?('games.json')
      games = []
    else
      data = File.read('games.json').split
      games = JSON.parse(data.join)
    end

    games.push({ 'multiplayer' => @multiplayer, 'last_played_at' => @last_played_at, 'publish_date' => @publish_date })

    File.write('games.json', games.to_json)
  end
end
