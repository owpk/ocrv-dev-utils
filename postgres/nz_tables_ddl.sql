CREATE TABLE IF NOT EXISTS "nz_tasks" (
  "id" bigint PRIMARY KEY,
  "orgeh_id" bigint,
  "year" int,
  "dept_id" bigint,
  "task_type" varchar(100),
  "period_type" varchar(50),
  "work_plan_time" int,
  "performer_plan_time" int,
  "temperatu_zone" int,
  "status" varchar(50),
  "start_from" timestamp,
  "start_to" timestamp
);

CREATE TABLE IF NOT EXISTS "nz_month" (
  "nz_id" bigint,
  "month_id" bigint,
  PRIMARY KEY ("nz_id", "month_id")
);

CREATE TABLE IF NOT EXISTS "nz_employees" (
  "id" bigint PRIMARY KEY,
  "login" int,
  "name" varchar(255)
);

CREATE TABLE IF NOT EXISTS "nz_employee_task" (
  "nz_id" bigint,
  "nz_employee_id" bigint,
  PRIMARY KEY ("nz_id", "nz_employee_id")
);

CREATE TABLE IF NOT EXISTS "nz_cnsi_task" (
  "nz_id" bigint,
  "nz_cnsi_id" bigint,
  PRIMARY KEY ("nz_id", "nz_cnsi_id")
);

ALTER TABLE "nz_employee_task" DROP CONSTRAINT IF EXISTS fk_nz_empl_nz_task_id; 
ALTER TABLE "nz_employee_task" ADD CONSTRAINT fk_nz_empl_nz_task_id FOREIGN KEY (nz_id) REFERENCES "nz_tasks" (id);

ALTER TABLE "nz_employee_task" DROP CONSTRAINT IF EXISTS fk_nz_cnsi_task_id; 
ALTER TABLE "nz_cnsi_task" ADD CONSTRAINT fk_nz_cnsi_task_id FOREIGN KEY (nz_id) REFERENCES "nz_tasks" (id);

ALTER TABLE "nz_month" DROP CONSTRAINT IF EXISTS fk_nz_month_task_id; 
ALTER TABLE "nz_month" ADD CONSTRAINT fk_nz_month_task_id FOREIGN KEY (nz_id) REFERENCES "nz_tasks" (id);

ALTER TABLE "nz_employee_task" DROP CONSTRAINT IF EXISTS fk_nz_task_empl_id; 
ALTER TABLE "nz_employee_task" ADD CONSTRAINT fk_nz_task_empl_id FOREIGN KEY (nz_employee_id) REFERENCES "nz_employees" (id);

