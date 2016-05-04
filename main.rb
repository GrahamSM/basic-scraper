require 'nokogiri'
require 'rubygems'
require 'open-uri'
require_relative 'post'
require_relative 'comment'

my_post = Post.new
my_post.add_comments
#puts my_post.extract_usernames(my_post.doc)
puts "Post title: #{my_post.title}".blue
puts ""
puts "Post points: #{my_post.points[0]}".yellow
puts ""
puts "URL Item ID: #{my_post.item_id}".red
my_post.comments.each do |comment|
  puts ""
  puts "User: #{comment.user}".blue
  puts "#{comment.text}".green
end
