Ruby on Rails: Write down code in Ruby in rail for a simple employee hierarchy which has different types of employees.
1. CEO
2. VP
3. Director
4. Manager
5. SDE

CEO doesn’t report to anybody and apart from CEO every other employee reports to someone else. 
Apart from “SDE” role every other role can have multiple reportee. 
The role “SDE” role is not allowed to have reportee under them. 

1.	Create a rest endpoint to input employee details (name, id, salary, rating etc.) in any order (employees might be input before his manager)
2.	Create a rest endpoint to print hierarchy given any position in the above-mentioned organization (Direction: bottom to top).
3.	Top 10 employees with ratio of salary 
4.	Create an rest endpoint which mark an employee resigned and delete the employee from the organization hierarchy. On removal of Managerial role all reportee should report to his/her reporter.  





INSTRUCTION:
------------------------------------------------------------------------------------------------------------------------------
1.	Focus on modular, extensible and clean code.  
