INSERT INTO user_account (username, password, email, first_name, last_name) VALUES
  ('sjlynn', 'pass1234', 'test@gmail.com', 'Sierra', 'Lynn'), 
  ('jlynn', 'pass1234', 'josephlynn94@gmail.com', 'Joe', 'Lynn');

SELECT * FROM user_account;

INSERT INTO employee (employee_name, user_account_id) VALUES
  ('Sierra Lynn', 1),
  ('Joseph Lynn', 2);

SELECT * FROM employee;

INSERT INTO team (team_name) VALUES 
  ('BubblyNet'),
  ('Buyers');

SELECT * FROM team;

INSERT INTO role (role_name) VALUES 
  ('Developer'),
  ('Designer');

SELECT * FROM role;

INSERT INTO team_member (employee_id, role_id, team_id) VALUES 
  (1, 2, 2),
  (2, 1, 1);

SELECT * FROM team_member;

INSERT INTO task (task_name, prority, description, status, planned_end_date) VALUES 
  ('Testing task 1', 2, 'This is a cool description', 'Backlog', '2022-06-27'),
  ('Testing task 2', 1, 'This is a cool description of another task', 'In Review', '2022-06-29');

SELECT * FROM task;

INSERT INTO assigned (employee_id, role_id, task_id) VALUES 
  (1, 2, 3),
  (2, 1, 4);

  SELECT * FROM assigned;

INSERT INTO project (task_id, status, project_name, project_description, planned_end_date) VALUES 
  (1, 'Completed', 'Cool Project', 'Awesome project description', '2022-06-10'),
  (2, 'Todo', '2nd Cool Project', 'Awesome project description #2', '2022-06-15');

SELECT * FROM project;