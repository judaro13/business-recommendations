class User < ActiveRecord::Base
  has_many :reviews
  validates_uniqueness_of :yid
end
