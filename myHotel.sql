DROP DATABASE IF EXISTS myHotel;

CREATE DATABASE myHotel;

USE myHotel;

DROP TABLE IF EXISTS `hotel`;

-- TABLES TO DO :
      -- Floors
          -- id - primary key - TINYINT(2)
          -- windows - TINYINT(2)
          -- room_id - foreign key - TINYINT(3)
      -- Rooms
          -- id - primary key
          -- max_occup - TINYINT(2)
          -- type - ENUM('janitor closet', 'public laundry', 'gym', 'guests')
          -- free_after - DATE

CREATE TABLE `rooms` (
    id INT AUTO_INCREMENT PRIMARY KEY
    ,kitchen BOOLEAN
    ,carpets BOOLEAN
    ,type ENUM('janitor closet', 'public laundry', 'gym', 'guests') -- NOT NULL
    , max_occup TINYINT(2)
    , free_after DATE
    , windows TINYINT(2)
);

CREATE TABLE `floors` (
    id INT AUTO_INCREMENT PRIMARY KEY
    , floor_name VARCHAR(15)
    , room_id INT
    , FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
);

INSERT INTO rooms(type, kitchen, carpets, max_occup, free_after, windows)
  VALUES
    ('gym', true, true, NULL, NULL, 1)
    ,('public laundry', false, true,  NULL, NULL, 1)
    ,('guests', false, false, 2, '2017-07-10', 2)
    ,('guests', false, true, 2, '2017-07-12', 4)
    ,('public laundry', false, true, NULL, NULL, 1)
    ,('guests', true, false, 5, '2017-07-10', 1)
    ,('guests', true, false, 2, '2017-07-12', 1)
    ,('public laundry', false, true, NULL, NULL, 3)
    ,('guests', false, true, 4, '2017-07-10', 4)
    ,('guests', false, false, 4, '2017-07-10',5)
    ,('guests', false, false, 5, '2017-07-13', 6)
    ,('guests', false, false, 4, '2017-07-12', 1)
    ,('guests', false, false, 2, '2017-07-10', 3)
    ,('janitor closet', false, true, NULL, NULL, 2)
    ,('guests', true, 5, true, '2017-07-12', 4)
    ,('guests', true, 1, false, '2017-07-10', 1)
    ,('guests', true, 1, true, '2017-07-11', 1)
    ,('guests', true, 2, false, '2017-07-10', 2)
;


INSERT INTO floors (floor_name, room_id)
  VALUES
    ('underground', 1)
  , ('underground', 2)
  , ('underground', 3)
  , ('first floor', 4)
  , ('first floor', 5)
  , ('first floor', 6)
  , ('first floor', 7)
  , ('second floor', 8)
  , ('second floor', 9)
  , ('second floor', 10)
  , ('second floor', 11)
  , ('third floor', 12)
  , ('third floor', 13)
  , ('third floor', 14)
  , ('third floor', 15)
  , ('third floor', 16)
  , ('third floor', 17)
  , ('third floor', 18)
;



select * from rooms;
select * from floors;

-- SELECT room_id FROM floors WHERE carpets = true;

-- The list of Rooms available for rent on a specific date
SELECT COUNT(*) FROM rooms WHERE DATEDIFF(CURDATE(), free_after) > 0;
--
-- The list of Rooms which can be occupied by at least 3 people on a specific date
SELECT * FROM rooms WHERE max_occup > 3 AND DATEDIFF('2017-07-11', free_after) > 0;

-- The amount of unrentable Rooms (janitor closets, public laundry room, gym, etc.)
SELECT COUNT(*) FROM rooms WHERE type != 'guests';

-- The amount of Rooms having a private Kitchen
SELECT COUNT(*) FROM rooms WHERE kitchen = true;

-- The average amount of windows per Floor
SELECT AVG(windows) AS floor_average FROM rooms JOIN floors
  ON (rooms.id = floors.room_id) GROUP BY floor_name;

-- The amount of Floors having Rooms with carpets
-- SELECT COUNT(*) FROM floors WHERE rooms JOIN floors
--   ON (rooms.id = floors.room_id) AND ON rooms.carpets = true GROUP BY floor_name;
