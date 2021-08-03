class Article < ActiveRecord::Base
  #create new article=================

  # a = Article.new(title: "Second", description: "Azy 2nd description")
  # with new mtd we have to use save
  # a.save
  # will return true if saved
  # ======but with create can save record directly
  # a = Article.create(title: "third", description: "Zyx 3nd description")
  # will return the record
  #
  #Edit/update the article==============
  # first find the article
  # article = Article.find(1) default by id
  # Article.where(title: "Firs article")
  # article.title = "Updated title"
  # article.save
  #
  #Delete/destroy the article==============
  # first find the article
  # article = Article.find(1) default by id
  # article.destroy
  # no need to call save it is auto commit cmd like create
  #
  # Validation article b/f saving it================================
  # To maintain data integrity we use validation so no invalid data get into DB
  # like title/description can't be nil => bad data
  #
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
  # a.errors
  # a.errors.full_messages
  # Article.new(description: "Zyx 3nd description").valid? => false
  #

end