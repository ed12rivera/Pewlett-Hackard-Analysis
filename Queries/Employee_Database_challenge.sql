-- Query employees and their titles who are eligible for retirement.
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retiring_summary
FROM employees e
JOIN titles t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY 1;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retiring_summary
ORDER BY emp_no, to_date DESC;

-- Retrieve number of retiring employees by title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY 1 DESC;

-- Create table of employees who are eligible for mentorship program
SELECT DISTINCT ON(e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	t.title
INTO mentor_eligible
FROM employees e
JOIN dept_emp d
ON e.emp_no = d.emp_no
JOIN titles t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (d.to_date = '9999-01-01')
ORDER BY 1;