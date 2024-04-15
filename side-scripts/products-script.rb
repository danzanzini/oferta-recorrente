puts 'oi'

file_name = './new_prices.xlsx'
xlsx = Roo::Spreadsheet.open(file_name)
xlsx.info