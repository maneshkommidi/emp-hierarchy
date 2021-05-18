module Api
  module V1
    class EmployeesController < ApplicationController
    	def create
    		@employee = Employee.new(emp_params)
    		if @employee.save
    			render json: @employee
    		else
    			render json: {error: @employee.errors.messages}, status:400
    		end
    	end

    	def top_paid_emps
    		@employees = Employee.order(salary: :desc).limit(10)
    		render json: @employees.to_json( only: :name, methods: :ratio )
    	end

      def emp_hierarchy
        emp_hierarchy_result = []
        Employee.top_execs.includes(subordinates: {subordinates: {subordinates: {subordinates: :subordinates}}}).each do |emp|
          emp_hierarchy_result << data(emp)
        end
        render json: emp_hierarchy_result.to_json
      end

      def destory
        @employee = Employee.find_by(id: params[:id])
        if @employee
          @employee.update(status: "Resigned")
          @employee.destroy
          render json: @employee.reload
        else
          render json: {error: 'Employee not found'}, status:400
        end
      end

    	private

    	def emp_params
        params.require(:employee).permit(
          :name,
          :salary,
          :rating,
          :manager_id,
          :role,
          :status
        )
    	end

      def data(employee)
        subordinates = []
        unless employee.subordinates.blank?
          employee.subordinates.each do |emp|
            subordinates << data(emp)
          end
        end
        {name: employee.name, role: employee.role, subordinates: subordinates}
      end
    end
  end
end