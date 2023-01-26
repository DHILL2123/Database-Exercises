/*Create a new file called select_exercises.sql. Store your code for this exercise in that file. You should be testing your code in MySQL Workbench as you go.

Use the albums_db database.

Explore the structure of the albums table.

a. How many rows are in the albums table?
--31
b. How many unique artist names are in the albums table?
--23
c. What is the primary key for the albums table?
--id
d. What is the oldest release date for any album in the albums table? What is the most recent release date?
--1967 and 2011
Write queries to find the following information:

a. The name of all albums by Pink Floyd
--The Wall, The Dark Side of the Moon

b. The year Sgt. Pepper's Lonely Hearts Club Band was released
--1967

c. The genre for the album Nevermind
--'Grunge, Alternative rock'

d. Which albums were released in the 1990s
--'The Immaculate Collection', '1990', 
--'Dangerous', '1991'
--'Metallica', '1991'
--'Nevermind', '1991'
--'The Bodyguard', '1992'
--'Jagged Little Pill', '1995'
--'Falling into You', '1996'
--'Come On Over', '1997'
--'Let\'s Talk About Love', '1997'
--Titanic: Music from the Motion Picture', '1997'
--'Supernatural', '1999'


e. Which albums had less than 20 million certified sales
--'14.4','Grease: The Original Soundtrack from the Motion Picture'
'19.3','Bad'
'13.1','Sgt. Pepper\'s Lonely Hearts Club Band'
'17.9','Dirty Dancing'
'19.3','Let\'s Talk About Love'
'16.3','Dangerous'
'19.4','The Immaculate Collection'
'14.4','Abbey Road'
'19.6','Born in the U.S.A.'
'17.7','Brothers in Arms'
'18.1','Titanic: Music from the Motion Picture'
'16.7','Nevermind'
'17.6','The Wall'


f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
--Rock is a specific genre

Be sure to add, commit, and push your work.*/

use albums_db;
select * from albums;
SELECT
DISTINCT artist
FROM albums;
DESCRIBE albums;
SELECT release_date
FROM albums
ORDER BY release_date asc;


SELECT  genre, name
FROM albums 
Where genre = 'rock';
