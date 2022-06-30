# Using Ruby version: ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux]
# Your Ruby code here
# frozen_string_literal: true

require 'csv'
# Creating a method in CSV class to group by designation
class CSV
    def self.group_by_designation(path)
        file_read = CSV.read(path, headers: true, header_converters: :symbol)
        
        hash = Hash.new {|hash,key| hash[key] = []}
        file_write = CSV.open('output.csv', 'w')
        file_read.each {|row| hash[row[:designation]] << [row[:name], row[:empid]]}

        hash.sort.each do |key, val|
            file_write << [key]
            val.sort {|a,b| a[1] <=> b[1]}.each do |entry|
                file_write << ["#{entry[0]} (EmpId: #{entry[1]})"]
            end
            file_write << []
        end
    end
end

CSV.group_by_designation('data.csv')