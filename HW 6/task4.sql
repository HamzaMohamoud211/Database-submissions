-- 1
-- List the names of customers who spent more than 450.00 on a single bill on occasions when ‘Charles’ was their Headwaiter.

SELECT DISTINCT b.cust_name
FROM restBill b
JOIN restRoom_management rm ON b.table_no IN (
    SELECT table_no FROM restRest_table WHERE room_name = rm.room_name
)
JOIN restStaff s ON rm.headwaiter = s.staff_no
WHERE s.first_name = 'Charles' AND b.bill_total > 450.00;

-- 2
-- A customer called Nerida has complained about a waiter on the 11th January 2016. Who is the Headwaiter?

SELECT DISTINCT s.first_name, s.surname
FROM restStaff s
WHERE s.staff_no = (
    SELECT headwaiter
    FROM restRoom_management rm
    WHERE rm.room_name = (
        SELECT room_name
        FROM restRest_table rt
        WHERE rt.table_no = (
            SELECT b.table_no
            FROM restBill b
            WHERE b.cust_name = 'Nerida Smith' AND b.bill_date = 160111
        )
    ) AND rm.room_date = 160111
);

-- 3
-- What are the names of customers with the smallest bill?

SELECT DISTINCT cust_name
FROM restBill
WHERE bill_total = (SELECT MIN(bill_total) FROM restBill);

-- 4
-- List the names of any waiters who have not taken any bills.

SELECT s.first_name, s.surname
FROM restStaff s
WHERE s.staff_no NOT IN (
    SELECT DISTINCT waiter_no
    FROM restBill
);

-- 5
-- Which customers had the largest single bill? List the customer name, the name and surname of headwaiters, and the room name where they were served on that occasion.

SELECT b.cust_name, h.first_name AS headwaiter_first_name, h.surname AS headwaiter_surname, rm.room_name
FROM restBill b
JOIN restRest_table rt ON b.table_no = rt.table_no
JOIN restRoom_management rm ON rm.room_name = rt.room_name AND rm.room_date = b.bill_date
JOIN restStaff h ON rm.headwaiter = h.staff_no
WHERE b.bill_total = (SELECT MAX(bill_total) FROM restBill);
