REPORT ZSK_EMP_REPORT.

TABLES: zsk_employee.

DATA: gt_emp TYPE TABLE OF zsk_employee,
      gs_emp TYPE zsk_employee.

PARAMETERS: p_dept TYPE zsk_employee-department.

SELECT-OPTIONS: s_empid FOR zsk_employee-emp_id.

AT SELECTION-SCREEN.

  IF p_dept IS INITIAL.
    MESSAGE 'Department cannot be empty' TYPE 'E'.
  ENDIF.

  IF p_dept <> 'IT'
  AND p_dept <> 'HR'
  AND p_dept <> 'Finance'
  AND p_dept <> 'Sales'
  AND p_dept <> 'Support'.

    MESSAGE 'Invalid Department' TYPE 'E'.

  ENDIF.


START-OF-SELECTION.

SELECT *
  FROM zsk_employee
  INTO TABLE gt_emp
  WHERE department = p_dept
  AND emp_id IN s_empid.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING
    i_structure_name = 'ZSK_EMPLOYEE'

  TABLES
    t_outtab = gt_emp.
