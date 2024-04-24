require 'roo'

file_name = './side-scripts/products-original.xlsx'
xlsx = Roo::Spreadsheet.open(file_name)
sheet = xlsx.sheet(xlsx.sheets.first)

helper_list = []
normalized_list = []

sheet.each do |hash|
  item = hash.first
  item.strip!
  helper_list << if item.match(/[\/|+|,]/)
                   item.split(/[\/|+|]/)
                 else
                    item.split(" e ")
                 end
end

helper_list.flatten!
helper_list.uniq!
helper_list.each do |item|
  item = item.split('(').first || item
  item.strip!
  item.capitalize!
  item.gsub!('  ', ' ')
  normalized_list << item
end

normalized_list.uniq!
normalized_list.sort!
puts normalized_list
puts normalized_list.count
