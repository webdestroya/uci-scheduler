class DisableDeadDepartments < ActiveRecord::Migration
  def up
    Department.where(code: ["ENVIRON", "RAD SCI"]).each do |dep|
      dep.disable!
    end
  end

  def down
    Department.where(code: ["ENVIRON", "RAD SCI"]).each do |dep|
      dep.enable!
    end
  end
end
