class Department < ActiveRecord::Base
  attr_accessible :code, :name

  scope :active,   -> { where(active: true) }

  def disable!
    self.update_column(:active, false)
  end

  def enable!
    self.update_column(:active, true)
  end

  def to_s
    self.code
  end
end
