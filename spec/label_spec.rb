require_relative '../label/label'
require_relative '../label/label_controller'
require_relative '../book/book'
require 'yaml'

describe Label do
  include LabelsController
  it 'item should be added to array' do
    label = Label.new('label')
    book = Book.new('20/10/2010', 'publisher', 'good')
    label.add_item(book)
    expect(label.items).to contain_exactly(book)
  end

  it "item\'s label should be set to current label\'s name" do
    label = Label.new('label')
    book = Book.new('20/10/2010', 'publisher', 'good')
    label.add_item(book)
    book.label.should eql 'label'
  end

  it 'should store labels' do
    labels = [Label.new('label1'), Label.new('label2')]
    store_labels(labels)
    expect(File.exist?('./label/labels.json') && File.read('./label/labels.json') != '').to eq true
    File.write('./label/labels.json', '')
  end
end
