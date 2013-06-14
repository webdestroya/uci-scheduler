class Department < ActiveRecord::Base
  attr_accessible :code, :name

  def to_s
    self.code
  end
end
