class Term < ActiveRecord::Base
  # attr_accessible :code, :current, :name

  has_many :courses

  def self.current
    Term.readonly.where(current: true).first
  end

  def set_current!
    cur_term = Term.current
    if cur_term
      cur_term.update_column(:current, false)
    end
    self.update_column(:current, true)
  end
end
