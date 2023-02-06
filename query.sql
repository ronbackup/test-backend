-- PERTANYAAN 1
SELECT 
	te.employee_id,
	te.name,
	tr.name AS religion_name,
	ta.address,
	SUM(tp.amount) AS amount
FROM tbl_employee AS te
LEFT JOIN tbl_religion AS tr ON tr.religion_id = te.religion_id
LEFT JOIN 
	(
		SELECT * FROM tbl_address WHERE seq = 1
	) AS ta ON ta.employee_id = te.employee_id
LEFT JOIN 
	(
		SELECT * FROM tbl_payroll WHERE type = 'THR'
	) AS tp ON tp.employee_id = te.employee_id
GROUP BY te.employee_id


-- PERTANYAAN 2
SELECT 
	te.employee_id,
	te.name,
	tr.name AS religion_name,
	ta.address,
	SUM(tp.amount) AS amount
FROM tbl_employee AS te
LEFT JOIN tbl_religion AS tr ON tr.religion_id = te.religion_id
LEFT JOIN 
	(
		SELECT employee_id, address FROM tbl_address 
		WHERE seq IN
			(
				SELECT min(seq) FROM tbl_address WHERE employee_id = employee_id GROUP BY employee_id ASC
			)
	) AS ta ON ta.employee_id = te.employee_id
	
LEFT JOIN 
	(
		SELECT * FROM tbl_payroll
	) AS tp ON tp.employee_id = te.employee_id
GROUP BY employee_id

