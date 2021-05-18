class Employee < ApplicationRecord
	acts_as_paranoid
	has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"
	belongs_to :manager, class_name: "Employee", foreign_key: "manager_id", optional: true

	validate :validate_manager
	validates :role, inclusion: { in: %w(CEO VP Director Manager SDE) }

	scope :top_execs, -> { where(manager_id: nil) }

	def ratio
		salary/Employee.pluck(:salary).sum
	end

	def validate_manager
		emp = Employee.find_by(id: self.manager_id)
		if emp && emp.role == 'SDE'
			validation_error('Manager cannot be SDE')
		elsif self.role == 'CEO' && emp.present?
			validation_error('CEO should not have a manager')
		elsif self.role == 'VP' && emp && emp.role != 'CEO'
			validation_error('VP manager should be CEO')
		elsif self.role == 'Director' && emp && emp.role != 'VP'
			validation_error('Director manager should be VP')
		elsif self.role == 'Manager' && emp && emp.role != 'Director'
			validation_error('Managers role manager should be VP')
		elsif self.role == 'SDE' && emp && emp.role != 'Manager'
			validation_error('SDE manager should be Manager')
		else
			true
		end
	end

	def validation_error(message)
		errors.add(:manager_id, message)
		false
	end
end
