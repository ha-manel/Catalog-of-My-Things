require 'json'

module LabelsController
  def store_labels(labels)
    return if labels.empty?
    file = './label/labels.json'
    File.new('./label/labels.json', 'w+') unless File.exist?(file)

    data = []

    labels.each do |label|
      data << { id: label.id, name: label.name }
    end
    File.write(file, JSON.generate(data))
  end

  def load_labels
    data = []
    file = './label/labels.json'
    return data unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |label|
      data << Label.new(label['name'], label['id'])
    end

    data
  end

  def list_labels
    puts '-' * 50
    if @labels.empty?
      puts 'The Labels list is empty'
    else
      puts '🏷️  Labels list:'
      @labels.each_with_index do |label, index|
        puts "#{index + 1}-[Label] ID: #{label.id} | Name: #{label.name}"
      end
    end
  end
end
