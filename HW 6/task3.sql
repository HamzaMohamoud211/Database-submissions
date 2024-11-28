-- 1
-- List the names of the waiters who have served the customer Tanya Singh.

SELECT DISTINCT s.first_name, s.surname
FROM restStaff s
JOIN restBill b ON s.staff_no = b.waiter_no
WHERE b.cust_name = 'Tanya Singh';

-- 2
-- On which dates in February 2016 did the Headwaiter 'Charles' manage the 'Green' room? The output date should be in the format they are stored.

SELECT rm.room_date
FROM restRoom_management rm
JOIN restStaff s ON rm.headwaiter = s.staff_no
WHERE s.first_name = 'Charles' AND rm.room_name = 'Green'
  AND rm.room_date BETWEEN 160201 AND 160229;

-- 3
-- List the names and surnames of the waiters with the same headwaiter as the waiter Zoe Ball.

SELECT DISTINCT s.first_name, s.surname
FROM restStaff s
WHERE s.headwaiter = (
    SELECT headwaiter
    FROM restStaff
    WHERE first_name = 'Zoe' AND surname = 'Ball'
);

-- 4
-- List the customer name, the amount they spent, and the waiter’s name for all bills. Order the list by the amount spent, highest bill first.

SELECT b.cust_name, b.bill_total, s.first_name, s.surname
FROM restBill b
JOIN restStaff s ON b.waiter_no = s.staff_no
ORDER BY b.bill_total DESC;

-- 5
-- List the names and surnames of the waiters who serve tables that worked in the same team that served bills 00014 and 00017.

SELECT DISTINCT s.first_name, s.surname
FROM restStaff s
WHERE s.headwaiter IN (
    SELECT headwaiter
    FROM restStaff
    WHERE staff_no IN (
        SELECT waiter_no
        FROM restBill
        WHERE bill_no IN (14, 17)
    )
);

-- 6
-- List the names and surnames of the waiters in the team (including the headwaiter) that served Blue room on 160312.

SELECT s.first_name, s.surname
FROM restStaff s
WHERE s.staff_no IN (
    SELECT waiter_no
    FROM restBill
    WHERE table_no IN (
        SELECT table_no
        FROM restRest_table
        WHERE room_name = 'Blue'
    ) AND bill_date = 160312
)
OR s.staff_no IN (
    SELECT headwaiter
    FROM restRoom_management
    WHERE room_name = 'Blue' AND room_date = 160312
);
