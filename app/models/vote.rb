class Vote < ActiveRecord::Base
  belongs_to :voted, :polymorphic => true
  belongs_to :user
  
  validates_uniqueness_of :voted_id, :scope => [:user_id, :voted_type]
end
