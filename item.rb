require 'date'

class Item
  def initialize(publish_date, archived, id=Random.rand(1..1000))
    @publish_date=Date.parse(publish_date)
    @archived=archived
    @id=id
  end
  attr_reader :publish_date, :archived, :id, :author, :label, :genre
  
  def genre=(genre)
    @genre=genre
  end
  def author=(author)
    @author=author
  end
  def label=(label)
    @label=label
  end
end    