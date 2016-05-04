require 'nokogiri'
require 'rubygems'
require 'open-uri'
require 'pry'

class Comment

  @@doc = Nokogiri::HTML(open("post.html"))

  attr_reader :text
  attr_accessor :user

  def initialize(text,user)
    @text = text
    @user = user
  end

  #@param user
  #@return user (if user is found)
  def find_user(user)
    @@doc.search('.comhead > a:first-child').map do |font|
      if font.text == user
        return user
        break
      end
    end
  end
end
