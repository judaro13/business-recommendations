class Business < ActiveRecord::Base
  validates_uniqueness_of :yid
end
