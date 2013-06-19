class Building < ActiveRecord::Base
  attr_accessible :abbr, :name

  def finder_url
    "https://eee.uci.edu/toolbox/roomfinder/room.php?building_abbr=#{self.abbr}"
  end
end
