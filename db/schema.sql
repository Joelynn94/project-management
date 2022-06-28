CREATE TABLE user_account (
  id SERIAL PRIMARY KEY,
  username VARCHAR(64),
  password VARCHAR(64),
  email VARCHAR(255),
  first_name VARCHAR(64),
  last_name VARCHAR(64),
  registration_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employee (
  id SERIAL PRIMARY KEY,
  employee_name VARCHAR(128),
  user_account_id INT,
  FOREIGN KEY (user_account_id) REFERENCES user_account(id) ON DELETE CASCADE
);

CREATE TABLE team (
  id SERIAL PRIMARY KEY,
  team_name VARCHAR(128)
);

CREATE TABLE role (
  id SERIAL PRIMARY KEY,
  role_name VARCHAR(128)
);

CREATE TABLE team_member (
  id SERIAL PRIMARY KEY,
  employee_id INT,
  role_id INT,
  team_id INT,
  FOREIGN KEY (employee_id) REFERENCES employee(id) ON DELETE CASCADE,
  FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
  FOREIGN KEY (team_id) REFERENCES team(id) ON DELETE CASCADE
);

CREATE TYPE status AS ENUM (
  'Backlog',
  'Todo',
  'In Progress',
  'In Review',
  'Completed'
);

CREATE TABLE task (
  id SERIAL PRIMARY KEY,
  task_name VARCHAR(255),
  prority INT,
  description TEXT,
  status status,
  planned_start_date DATE NULL,
  planned_end_date DATE,
  actual_start_time DATE NULL,
  actual_end_time DATE NULL
);

CREATE TABLE assigned (
  id SERIAL PRIMARY KEY,
  employee_id INT,
  role_id INT,
  task_id INT,
  FOREIGN KEY (employee_id) REFERENCES employee(id) ON DELETE CASCADE,
  FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
  FOREIGN KEY (task_id) REFERENCES task(id) ON DELETE CASCADE
);

CREATE TABLE project (
  id SERIAL PRIMARY KEY,
  task_id INT,
  status status,
  project_name VARCHAR(128),
  project_description TEXT NULL,
  planned_start_date DATE NULL,
  planned_end_date DATE,
  planned_budget DECIMAL(19,2) NULL,
  actual_start_time DATE NULL,
  actual_end_time DATE NULL
  actual_budget DECIMAL(19,2) NULL,
  FOREIGN KEY (task_id) REFERENCES task(id) ON DELETE CASCADE
);

CREATE TABLE project_manager (
  id SERIAL PRIMARY KEY,
  user_account_id INT,
  project_id INT,
  FOREIGN KEY (user_account_id) REFERENCES user_account(id) ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE
);

CREATE TABLE client (
  id SERIAL PRIMARY KEY,
  client_name VARCHAR(255),
  client_address VARCHAR(255),
  client_details TEXT
);

CREATE TABLE on_project (
  id SERIAL PRIMARY KEY,
  project_id INT,
  client_id INT,
  description TEXT,
  date_start DATE,
  date_end DATE,
  is_client BOOLEAN,
  is_partner BOOLEAN,
  FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE,
  FOREIGN KEY (client_id) REFERENCES client(id) ON DELETE CASCADE
);
