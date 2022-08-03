require_relative '../game/game'
require_relative '../game/game_controller'

describe Game do
  include GamesController
  it 'Should be an instance of Game' do
    author = Game.new(true, '04-12-2011', '09-10-2017')
    expect(author).to be_instance_of Game
  end

  it 'archived should be true' do
    game = Game.new(true, '04-12-2017', '09-10-2010')
    game.move_to_archive
    game.archived.should eq true
  end

  it 'archived should be true' do
    game = Game.new(true, '04-12-2011', '09-10-2022')
    game.archived.should eq false
  end

  it 'Should store game in json file' do
    game = Game.new(true, '04-12-2011', '09-10-2017')
    save_game(game)
    expect(File.exist?('./game/games.json') && File.read('./game/games.json') != '').to eq true
    File.write('./game/games.json', '')
  end
end
