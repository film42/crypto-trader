class Currency < ActiveRecord::Base
  attr_accessible :last, :average, :volume, :volume_current
  attr_accessible :high, :low, :pair

  belongs_to :exchange
end
