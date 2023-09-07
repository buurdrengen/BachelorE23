using HiGHS

highs = Highs_create()

ret = Highs_setBoolOptionValue(highs,"log_to_console",false)

@assert ret == 0

Highs_addCol(highs, 1.0, 0.0, 4.0, 0, C_NULL, C_NULL)
Highs_addCol(highs, 1.0, 1.0, Inf, 0, C_NULL, C_NULL)

Highs_changeColIntegrality(highs, 1, kHighsVarTypeInteger)

Highs_changeObjectiveSense(highs, kHighsObjSenseMinimize)

senseP = Ref{Cint}(0)

Highs_getObjectiveSense(highs,senseP)

senseP[] == kHighsObjSenseMinimize

Highs_addRow(highs, 5.0, 15.0, 2,Cint[0,1],[1.0,2.0])

Highs_addRow(highs, 6.0, Inf, 2, Cint[0,1],[3.0,2.0])

Highs_run(highs)

col_value = zeros(Cdouble,2);

Highs_getSolution(highs, col_value, C_NULL, C_NULL, C_NULL)

col_value