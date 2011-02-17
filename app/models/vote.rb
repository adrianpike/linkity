class Vote < ActiveRecord::Base
  belongs_to :voted, :polymorphic => true
  belongs_to :user
end
