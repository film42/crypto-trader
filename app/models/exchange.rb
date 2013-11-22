class Exchange < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :currencies
end
