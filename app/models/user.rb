class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy

  #don't allow user with same username up or lowercase
  validates :username, presence: true, uniqueness: {case_sensitive: false},
            length: {minimum: 3, maximum: 25}

  #refer rubular.com for regex
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: {case_sensitive: false},
            length: {maximum: 105}, format: { with: VALID_EMAIL_REGEX }


  before_save { self.email = email.downcase }

  has_secure_password
  paginates_per 5

  #===============
  # Callback
  # https://guides.rubyonrails.org/active_record_callbacks.html
  # ==============

  # will trigger only for create event validation
  # before_validation :do_it_before_validation, on: :create, if: :should_run
  # before_validation :do_it_before_validation
  # after_validation :do_it_after_validation
  # around_create :do_it_around_create

  after_validation do
    #this run after all validation on all event(:create, :update)
    #when ur code so short to fit into one line
    puts("************do_it_after_validation**********")
  end

  after_initialize do |user|
    puts("********Initiaze am User Object*************")
    puts("********#{user}*************")
  end

  # first found the object and initialize it
  after_find do |user|
    puts("********Fond an User Object*************")
    puts("********#{user}*************")
  end


  private
  def do_it_before_validation
    puts("************Before validation**********")
    self.username.strip!
  end

  def do_it_around_create
    puts("************Around Create**********")
  end

  def should_run
    puts("************ I will return true **********")
    true
  end

end
