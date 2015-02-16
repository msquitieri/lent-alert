class User < ActiveRecord::Base
  validates_uniqueness_of :email
  validates :email, :email => true
end
