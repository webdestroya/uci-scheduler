class DisableDeadDepartments < ActiveRecord::Migration
  def up
    Department.find_by_code("ENVIRON").disable!
    Department.find_by_code("RAD SCI").disable!
  end

  def down
    Department.find_by_code("ENVIRON").enable!
    Department.find_by_code("RAD SCI").enable!
  end
end
