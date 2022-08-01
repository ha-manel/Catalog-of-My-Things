require 'json'

module LabelsController
  def store_labels(labels)
    file = './labels.json'
    File.new('labels.json', 'w+') unless File.exist?(file)

    data = []

    labels.each do |label|
      data << { id: label.id, name: label.name}
    end
    File.write(file, JSON.generate(data))
  end

  def load_labels
    data = []
    file = './labels.json'
    return data unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |label|
      data << Label.new(label['name'], label['id'])
    end

    data
  end
end