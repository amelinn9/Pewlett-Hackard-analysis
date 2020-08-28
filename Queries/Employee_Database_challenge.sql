-- MODULE 7 CHALLENGE -----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERABLE 1
-- Retirement Titles Table
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
--INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
							first_name,
							last_name,
							title
--INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Retiring Titles table
SELECT COUNT (emp_no), title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles;


-- DELIVERABLE 2
-- Mentorship Eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
--INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON(e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, t.to_date DESC;

SELECT * FROM mentorship_eligibility;


-- DELIVERABLE 3
-- revised retirement by titles
SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO revised_retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT * FROM revised_retirement_titles;

-- revised retirement by dept
SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		d.dept_name,
		de.from_date,
		de.to_date
INTO revised_retirement_dept
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- Retirement by titles & dept
SELECT rrt.emp_no,
		rrt.first_name,
		rrt.last_name,
		rrt.title,
		rrd.dept_name
INTO retirement_titles_dept
FROM revised_retirement_titles as rrt
INNER JOIN revised_retirement_dept as rrd
ON rrt.emp_no = rrd.emp_no
ORDER BY rrt.emp_no

-- Retiring Titles table
SELECT COUNT (emp_no), title
INTO revised_retiring_titles_count
FROM retirement_titles_dept
GROUP BY title
ORDER BY count DESC;

-- Retiring Dept table
SELECT COUNT (emp_no), dept_name
INTO revised_retiring_dept_count
FROM retirement_titles_dept
GROUP BY dept_name
ORDER BY count DESC;

-- Retiring table counts by dept & title
SELECT rtd.dept_name,
		rtd.title,
COUNT (rtd.emp_no)
INTO retirement_count
FROM retirement_titles_dept as rtd
GROUP BY rtd.dept_name, rtd.title
ORDER BY rtd.dept_name, rtd.title;

SELECT * FROM retirement_count;



-- Mentorship Eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		t.title,
		d.dept_name,
		de.to_date
INTO revised_mentorship_eligibility
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
INNER JOIN dept_emp as de
ON(e.emp_no = de.emp_no)
INNER JOIN departments as d
ON (d.dept_no = de.dept_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no, de.to_date DESC;

SELECT * FROM revised_mentorship_eligibility;

-- Mentorship Eligibility table counts by dept & title
SELECT rme.dept_name,
		rme.title,
COUNT (rme.emp_no)
INTO mentorship_eligibility_count
FROM revised_mentorship_eligibility as rme
GROUP BY rme.dept_name, rme.title
ORDER BY rme.dept_name, rme.title;

SELECT * FROM mentorship_eligibility_count;