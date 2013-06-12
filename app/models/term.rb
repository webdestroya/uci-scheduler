class Term < ActiveRecord::Base
  # attr_accessible :code, :current, :name

  def set_current!
    cur_term = Term.where(current: true).first
    if cur_term
      cur_term.update_column(:current, false)
    end
    self.update_column(:current, true)
  end
end
