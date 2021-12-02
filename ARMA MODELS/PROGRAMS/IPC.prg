'***************************************************************************************
'PC2'
'PREGUNTA 1 SERIE IPC
'***************************************************************************************
'Escogemos nuestra ruta donde está guardada nuestra base de datos
cd "D:\2020-2\ECO2\PC2\grupo4\pregunta 1\pregunta1_1"

'Abrimos nuestra base
import(page=Trimestrales2) "ipc.TRIM1999.xlsx" range="Hoja1" @freq Q 1999

'A) Inspeccionamos la serie

'Transformamos la serie en diferencias
series  ln_ipc=log(ipc)
freeze(graf1)ln_ipc.line


'Desestacionalizamos
pageselect Trimestrales2
ln_ipc.x13(save="d11", tf=log, arimasmpl="1999Q1 2019Q4")  @x11()
rename ln_ipc_d11 lnipc_sa
freeze(graf2) lnipc_sa.line
rename lnipc_sa lnipc

'Transformamos las series en diferencias
pageselect Trimestrales2
series gipc= lnipc - lnipc(-1)
series gipc4= lnipc - lnipc(-4)

'La serie es estacionaria?

pageselect Trimestrales2
lnipc.uroot(exog=trend, lagmethod=maic)
'Con el test ADF y lag length medido con modified Schwarz, la hipotesis nula  se rechaza, por lo tanto será estacionario
gipc.uroot(lagmethod=maic)

'El test ADF con intercepto señala que  se rechaza la nula al 95%, por lo que es estacionaria
gipc4.uroot(lagmethod=maic)

'El test ADF con intercepto da como resultado el rechazo de la hipotesis nula, por lo tanto es estacionaria.

'Calculamos ACF y PACF
lnipc.correl(60)
 'Según la forma del PACF, la serie se puede modelar como un AR(1)
gipc.correl(60)
' El PACF muestra que el se puede proponer un ARMA(1,3) o ARMA(1,4) dado que se corta en el lag 4
gipc4.correl(60)
'El PACF se corta en el  lag 1, por lo que se propone un ARMA(1, 4) o ARMA(1,5)

'Metodología Box-Jekins

'A) Estimacion: estimamos los modelos previamente seleccionados en la etapa anterior. 
'1.2.1)Para gipc
'Creamos una tabla para almacenar los coeficientes:
table(8,3) Seleccion_2
setcolwidth(seleccion_2, 1, 20) 'numero máximo de caracteres 20

seleccion_2(1,1) = "Model"
seleccion_2(2,1) = "ARMA(1,3)"
seleccion_2(3,1) = "ARMA(1,1)"
seleccion_2(4,1) = "ARMA(4,3)"
seleccion_2(5,1) = "ARMA(3,4)"
seleccion_2(1,2) = "AIC"
seleccion_2(1,3) = "SC"

'Estimamos y guardamos los principales estadisticos: 
equation eq1_1.ls gipc  c ar(1) ma(1)  ma(2) ma(3) 
seleccion_2(2,2) =@aic
seleccion_2(2,3)=@sc


equation eq2_1.ls gipc  c ar(1) ma(1)
seleccion_2(3,2) =@aic
seleccion_2(3,3)=@sc

equation eq3_1.ls gipc  c ar(1) ar(2) ar(3) ar(4) ma(1) ma(2) ma(3) 
seleccion_2(4,2) =@aic
seleccion_2(4,3)=@sc


equation eq4_1.ls gipc  c ar(1) ar(2) ar(3) ma(1) ma(2) ma(3) ma(4)
seleccion_2(5,2) =@aic
seleccion_2(5,3)=@sc


'Generamos los residuos de los modelos :
eq1_1.resids(g)  
eq1_1.makeresids eq1_1resids
eq1_1resids.correl

eq2_1.resids(g)
eq2_1.makeresids eq2_1resids
eq2_1resids.correl

eq3_1.resids(g)
eq3_1.makeresids eq3_1resids
eq3_1resids.correl

eq4_1.resids(g)
eq4_1.makeresids eq4_1resids
eq4_1resids.correl



' C) Diagnóstico: evaluamos los errores de la estimacion. 
show Seleccion_2

' El mejor modelo para las series en diferencias es ARMA(1,3)
'1.2.2) Para lnipc

'Creamos una tabla para almacenar los coeficientes:
table(8,3) Seleccion_2_1
setcolwidth(seleccion_2_1, 1, 20)

seleccion_2_1(1,1) = "Model"
seleccion_2_1(2,1) = "ARMA(1,1)"
seleccion_2_1(3,1) = "AR(1)"
seleccion_2_1(4,1) = "ARMA(1,4)"
seleccion_2_1(5,1) = "ARMA(4,4)"
seleccion_2_1(1,2) = "AIC"
seleccion_2_1(1,3) = "SC"

'Estimamos y guardamos los principales estadisticos: 
equation eq1_1_2.ls gipc  c ar(1) ma(1) 
seleccion_2_1(2,2) =@aic
seleccion_2_1(2,3)=@sc


equation eq2_1_2.ls gipc  c ar(1)
seleccion_2_1(3,2) =@aic
seleccion_2_1(3,3)=@sc

equation eq3_1_2.ls gipc  c ar(1) ma(4)
seleccion_2_1(4,2) =@aic
seleccion_2_1(4,3)=@sc


equation eq4_1_2.ls gipc  c ar(1) ar(2) ar(3) ar(4)  ma(4) 
seleccion_2_1(5,2) =@aic
seleccion_2_1(5,3)=@sc

'Generamos los residuos de los modelos :
eq1_1_2.resids(g)  
eq1_1_2.makeresids eq1_1_2resids
eq1_1_2resids.correl

eq2_1_2.resids(g)
eq2_1_2.makeresids eq2_1_2resids
eq2_1_2resids.correl

eq3_1_2.resids(g)
eq3_1_2.makeresids eq3_1_2resids
eq3_1_2resids.correl

eq4_1_2.resids(g)
eq4_1_2.makeresids eq4_1_2resids
eq4_1_2resids.correl

' C) Diagnóstico: evaluamos los errores de la estimacion. 
show Seleccion_2_1

' ARMA (1,4) Y ARMA (2,4) son buenos modelos par la serie lnpbi, pero segun el criterio de Scharwz y Akaike el mejor sera el ARMA(4,4).

'1.2.2) Para GIPC4 
table(8,3) Seleccion_2_2
setcolwidth(seleccion_2_2, 1, 20)

seleccion_2_2(1,1) = "Model"
seleccion_2_2(2,1) = "ARMA(1,2)"
seleccion_2_2(3,1) = "ARMA(1,4)"
seleccion_2_2(4,1) = "ARMA(1,5)"
seleccion_2_2(5,1) = "ARMA(4,4)"
seleccion_2_2(1,2) = "AIC"
seleccion_2_2(1,3) = "SC"

'Estimamos y guardamos los principales estadisticos: 
equation eq1_1_3.ls gipc  c ar(1) ma(2)
seleccion_2_2(2,2) =@aic
seleccion_2_2(2,3)=@sc


equation eq2_1_3.ls gipc  c ar(1) ma(4)
seleccion_2_2(3,2) =@aic
seleccion_2_2(3,3)=@sc

equation eq3_1_3.ls gipc  c ar(1) ma(5)
seleccion_2_2(4,2) =@aic
seleccion_2_2(4,3)=@sc


equation eq4_1_3.ls gipc  c ar(1) ar(2) ar(3) ar(4) ma(4) 
seleccion_2_2(5,2) =@aic
seleccion_2_2(5,3)=@sc


'Generamos los residuos de los modelos :
eq1_1_3.resids(g)  
eq1_1_3.makeresids eq1_1_3resids
eq1_1_3resids.correl

eq2_1_3.resids(g)
eq2_1_3.makeresids eq2_1_3resids
eq2_1_3resids.correl

eq3_1_3.resids(g)
eq3_1_3.makeresids eq3_1_3resids
eq3_1_3resids.correl

eq4_1_3.resids(g)
eq4_1_3.makeresids eq4_1_3resids
eq4_1_3resids.correl

' C) Diagnóstico: evaluamos los errores de la estimacion. 
show Seleccion_2_2
' Según el criterio de Scharwz y Akaike el mejor modelo para estimar el pbi con 4 rezagos  será el ARMA(4,4).


