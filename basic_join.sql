/*
https://www.hackerrank.com/domains/sql?filters%5Bstatus%5D%5B%5D=unsolved&badge_type=sql
*/

/*
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard!
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge.
Order your output in descending order by the total number of challenges in which the hacker earned a full score.
If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.
Difficulty: The difficult_level is the level of difficulty of the challenge, and score is the score of the challenge for the difficulty level.
Challenges: The challenge_id is the id of the challenge, the hacker_id is the id of the hacker who created the challenge, and difficulty_level is the level of difficulty of the challenge.
Submissions: The submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission,
challenge_id is the id of the challenge that the submission belongs to, and score is the score of the submission. 

*/

SELECT
    h.hacker_id,
    h.name
FROM Submissions s
INNER JOIN Hackers h
    ON s.hacker_id = h.hacker_id
INNER JOIN Challenges c
    ON c.challenge_id = s.challenge_id
INNER JOIN Challenges c
    ON c.challenge_id = s.challenge_id
INNER JOIN Difficulty d
    ON d.difficulty_level = c.difficulty_level
WHERE s.score = d.score
GROUP BY h.hacker_id, h.name
    HAVING COUNT(h.hacker_id) > 1
ORDER BY COUNT(h.hacker_id) DESC, h.hacker_id ASC;

--WITH SUBQUERRY 
SELECT 
    hacker_id,
    name 
FROM 
(
SELECT 
    h.hacker_id,
    h.name,
    count(h.hacker_id)
FROM submissions s
INNER JOIN challenges c
    ON s.challenge_id = c.challenge_id
INNER JOIN difficulty d
    ON c.difficulty_level = d.difficulty_level 
INNER JOIN hackers h
    ON s.hacker_id = h.hacker_id
WHERE s.score = d.score
GROUP BY h.hacker_id, h.name
HAVING COUNT(h.hacker_id) > 1
ORDER BY COUNT(h.hacker_id) DESC, h.hacker_id ASC);


/*
Ollivander's Inventory
Harry Potter and his friends are at Ollivander's with Ron,
finally replacing Charlie's old broken wand.

Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age.
Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, 
sorted in order of descending power. 
If more than one wand has same power, sort the result in order of descending age.
*/

SELECT
    Wands.id,
    min_prices.age,
    Wands.coins_needed,
    Wands.power
FROM
    Wands
INNER JOIN
    (SELECT
        w.code,
        w.power,
        min(wp.age) as age,
        min(w.coins_needed) as min_price
    FROM
        Wands w
    INNER JOIN Wands_Property wp
        ON wp.code = w.code
    WHERE wp.is_evil = 0
    GROUP BY w.code, w.power
    ORDER BY w.code, w.power) min_prices
ON Wands.code = min_prices.code
AND Wands.power = min_prices.power
AND Wands.coins_needed = min_prices.min_price
ORDER BY Wands.power DESC, min_prices.age DESC;

/*
Challenges
Julia asked her students to create some coding challenges.
Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
Sort your results by the total number of challenges in descending order. 
If more than one student created the same number of challenges, then sort the result by hacker_id. 
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created,
then exclude those students from the result.
*/

SELECT
    hacker_id,
    name,
    max(max_count.count)
FROM
    max_count
(SELECT
    h.hacker_id,
    h.name,
    c.challenge_id, 
    count(c.challenge_id) as count
FROM Hackers h
JOIN Challenges c
    ON c.hacker_id = h.hacker_id
GROUP BY h.hacker_id, h.name) max_count
JOIN hackers
    ON hackers.hacker_id = max_count.hacker_id
JOIN Challenges
    ON Challenges.challenge_id = max_count.challenge_id