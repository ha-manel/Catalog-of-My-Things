require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publish_date, publisher, cover_state, id = nil, archived: false)
    super(publish_date, id, archived: archived)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    (Date.today.year - @publish_date.year) > 10 || cover_state == 'bad'
  end
end
