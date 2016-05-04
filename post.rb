require 'nokogiri'
require 'rubygems'
require 'open-uri'
require 'pry'
require 'colorize'



class Post

  attr_reader :item_id, :doc, :url, :points, :title, :comments
  @@doc = Nokogiri::HTML(open("post.html"))

  def initialize
    @title = extract_title(doc)
    @url = ARGV
    @item_id = extract_item_id(@@doc)
    @points = extract_points(@@doc)
    @comments = add_comments
  end

  #Method to add a comment object to the @comments array for each comment in the post
  def add_comments
    @@doc.search('.athing').map do |comment|
      user = comment.search('.comhead > a:first-child').text
      text = comment.search('.comment > span:first-child').text
      Comment.new(text,user)
    end
  end

  #@param comment object
  #@return @comments
  def add_comment(comment)
    @comments << comment
  end

  #Extracts title of the post
  #@return @title
  def extract_title(doc) #Extracts title from the page
    @@doc.css("title").text.to_s
  end

  #Extracts item_id of the site url
  #@param doc
  #@return @item_id
  def extract_item_id(doc) #Extracts the item_id from the page
    doc.css('a').map do |link|
      if /item\?id=(.+)/.match(link['href'])
        return $1
        break
      end
    end
  end

  #Extracts amount of the points the post has
  #@param doc
  #@return @points
  def extract_points(doc) #Extracts the number of points from the post
    doc.search('.score').map do |element|
      element.text
    end
  end
end
