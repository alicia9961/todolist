--作業一：
--外來鍵：班級、姓別

--建立班級表
CREATE TABLE classes (
  id SERIAL PRIMARY KEY,       -- 班級代號
  name VARCHAR(20) NOT NULL    -- 班級名稱
);

-- 新增班級名稱
INSERT INTO classes (name) VALUES 
  ('三年一班'),
  ('三年二班');

-- 建立性別表
CREATE TABLE gender (
  id VARCHAR(10) PRIMARY KEY,   -- 性別代號
  name VARCHAR(20) NOT NULL     -- 性別名稱
);

-- 新增性別
INSERT INTO gender (id, name) VALUES 
  ('M', '男'),
  ('F', '女');

-- 建立學生資料表
CREATE TABLE students (
  id SERIAL PRIMARY KEY,       -- 學生編號 (PK)
  name VARCHAR(50) NOT NULL,   -- 學生姓名
  class_id INTEGER,            -- 學生班級代號 (FK)
  gender_id  VARCHAR(10),      -- 學生性別代號 (FK)
  age INTEGER ,                -- 學生年紀
  FOREIGN KEY  (class_id) REFERENCES classes(id),
  FOREIGN KEY (gender_id ) REFERENCES gender(id)
);

-- 新增學生資料
INSERT INTO students(name, class_id, gender_id, age) VALUES 
('小明', 1, 'M', 8),
('小華', 2, 'F', 9),
('小美', 1, 'F', 8),
('小強', 1, 'M', 8),
('小智', 2, 'M', 9);

-- 合併資料
SELECT 
    s.id AS 學生編號,
    s.name AS 姓名,
    c.name AS 班級,   -- 從 classes 表抓取中文名稱
    g.name AS 性別,   -- 從 gender 表抓取中文名稱
    s.age AS 年齡
FROM students s
INNER JOIN classes c ON s.class_id = c.id
INNER JOIN gender g ON s.gender_id = g.id;

-- ========================================================
-- 作業二：
-- 一個班級對應一位老師，更新classes表，新增teacher欄位
-- 其餘資料表不變

--建立班級表
CREATE TABLE classes (
  id SERIAL PRIMARY KEY,        -- 班級代號
  name VARCHAR(20) NOT NULL,     -- 班級名稱
  teacher VARCHAR(20) NOT NULL  -- 班級老師
);

-- 新增班級老師資料
INSERT INTO classes (name, teacher) VALUES 
  ('三年一班', '廖洧杰'),
  ('三年二班', '卡斯柏');

-- 建立性別表
CREATE TABLE gender (
  id VARCHAR(10) PRIMARY KEY,   -- 性別代號
  name VARCHAR(20) NOT NULL     -- 性別名稱
);

-- 新增性別
INSERT INTO gender (id, name) VALUES 
  ('M', '男'),
  ('F', '女');

-- 建立學生資料表
CREATE TABLE students (
  id SERIAL PRIMARY KEY,       -- 學生編號 (PK)
  name VARCHAR(50) NOT NULL,   -- 學生姓名
  class_id INTEGER,            -- 學生班級代號 (FK)
  gender_id  VARCHAR(10),      -- 學生性別代號 (FK)
  age INTEGER ,                -- 學生年紀
  FOREIGN KEY  (class_id) REFERENCES classes(id),
  FOREIGN KEY (gender_id ) REFERENCES gender(id)
);

-- 新增學生資料
INSERT INTO students(name, class_id, gender_id, age) VALUES 
('小明', 1, 'M', 8),
('小華', 2, 'F', 9),
('小美', 1, 'F', 8),
('小強', 1, 'M', 8),
('小智', 2, 'M', 9);

-- 合併資料
SELECT 
    s.id AS 學生編號,
    s.name AS 姓名,
    c.name AS 班級,          -- 從 classes 表抓取中文名稱
    c.teacher AS 班級老師,   -- 從 classes 表抓取班級老師
    g.name AS 性別,          -- 從 gender 表抓取中文名稱
    s.age AS 年齡
FROM students s
INNER JOIN classes c ON s.class_id = c.id
INNER JOIN gender g ON s.gender_id = g.id;
-- ========================================================
-- 作業三：

-- 建立性別表
CREATE TABLE gender (
  id VARCHAR(10) PRIMARY KEY,   -- 性別代號
  name VARCHAR(20) NOT NULL     -- 性別名稱
);

-- 新增性別
INSERT INTO gender (id, name) VALUES 
  ('M', '男'),
  ('F', '女');

-- 建立家長資料表
CREATE TABLE parents (
    id SERIAL PRIMARY KEY,       -- 家長id
    name VARCHAR(50) NOT NULL,   -- 家長姓名
    phone VARCHAR(50),           -- 家長電話
    gender_id VARCHAR(10),       -- 家長性別
    FOREIGN KEY (gender_id) REFERENCES gender(id)
);

-- 新增家長資料
INSERT INTO parents (name, phone, gender_id) VALUES
('王大祥', '0973254254', 'M'),
('王曉如', '0955717855', 'F');

-- 建立小孩資料表
CREATE TABLE children (
  id SERIAL PRIMARY KEY,  -- 小孩id
  name VARCHAR(50),       -- 小孩姓名      
  parent_id INTEGER,      -- 小孩父母id
  FOREIGN KEY (parent_id) REFERENCES parents(id)
);

-- 新增小孩資料
INSERT INTO children (name, parent_id) VALUES
('小明', 1),
('小華', 2),
('小美', 1),
('小強', 2),
('小智', 1);

-- 合併資料
SELECT 
    s.id AS 小孩編號,
    s.name AS 姓名,
    p.name AS 家長姓名,      -- 從 parents 表抓取家長姓名
    p.phone AS 家長電話,      -- 從 parents 表抓取家長電話
    g.name AS 性別           -- 從 gender 表抓取家長性別
FROM children s
INNER JOIN parents p ON s.parent_id = p.id
inner JOIN gender g ON p.gender_id = g.id;
