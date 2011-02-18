class Post < ActiveRecord::Base
  
  has_many :comments, :dependent => :destroy
  has_many :votes, :as => :voted, :dependent => :destroy
  belongs_to :user
  
  validates_presence_of :url
  validates_presence_of :user
  validates_format_of :url, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  
  def self.top(opts = {:limit => 100})
    self.all(:limit => opts[:limit]).sort{|a,b|
      b.score <=> a.score
    }
  end
  
  before_save :discover_name!
  
  def discover_name! # should find the title of the page
    unless self.name? then
      a = Mechanize.new { |agent|
        agent.open_timeout = 1.second
      }

      a.get(self.url) do |page|
        p page
        self.name = page.title
      end
    end
  end
  
  def display_score
    self.votes.sum(:value)
  end
  
  def age_in_minutes
    (Time.current.to_i - self.created_at.to_i).to_f / 1.minute.to_f
  end
  
  def score
    self.votes.sum(:value).to_f + (self.age_in_minutes * $minute_vote_weight)
  end
  
end
