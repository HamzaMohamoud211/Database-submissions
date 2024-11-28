-- 1
-- Which waiters have taken 2 or more bills on a single date? List the waiter names and surnames, the dates, and the number of bills they have taken.

SELECT s.first_name, s.surname, b.bill_date, COUNT(*) AS num_bills
FROM restBill b
JOIN restStaff s ON b.waiter_no = s.staff_no
GROUP BY s.first_name, s.surname, b.bill_date
HAVING COUNT(*) >= 2;

-- 2
-- List the rooms with tables that can serve more than 6 people and how many of such tables they have.

SELECT rt.room_name, COUNT(*) AS num_tables
FROM restRest_table rt
WHERE rt.no_of_seats > 6
GROUP BY rt.room_name;

-- 3
-- List the names of the rooms and the total amount of bills in each room.

SELECT rt.room_name, SUM(b.bill_total) AS total_bills
FROM restBill b
JOIN restRest_table rt ON b.table_no = rt.table_no
GROUP BY rt.room_name;

-- 4
-- List the headwaiter’s name and surname and the total bill amount their waiters have taken. Order the list by total bill amount, largest first.

SELECT h.first_name, h.surname, SUM(b.bill_total) AS total_bills
FROM restBill
