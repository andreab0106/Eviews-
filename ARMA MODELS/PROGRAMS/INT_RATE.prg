'***************************************************************************************
'PC2'
'PREGUNTA 1 SERIES tasa de interés
'***************************************************************************************
cd "C:\Ana\CATO\2020-2\ECONOMETRIA 2\PC-2\pregunta 1\programs final"

'Abrimos nuestra base
import(page=Trimestrales4) "tasa_de_referencia_TRIM_3.xlsx" range="Sheet1" @freq Q 2001

'A) Inspeccionamos la serie
freeze(graf1)tasa.line

'Transformamos la serie en diferencias
series gtasa= tasa - tasa(-1)
series gtasa4= tasa - tasa(-4)

'La serie es estacionaria?
tasa.uroot(lagmethod=maic)
tasa.uroot(dfgls, lagmethod=maic)
gtasa.uroot(lagmethod=maic)
gtasa4.uroot(lagmethod=maic)

'Calculamos ACF y PACF
tasa.correl(12)
gtasa.correl(12)
gtasa4.correl(12)

'Metodología Box-Jekins

'A) Estimacion: estimamos los modelos previamente seleccionados en la etapa anterior. 
'1.6)Para gtasa
'Creamos una tabla para almacenar los coeficientes:
table(8,3) Seleccion_6
setcolwidth(seleccion_6, 1, 20) 

seleccion_6(1,1) = "Model"
seleccion_6(2,1) = "MA(1)"
seleccion_6(3,1) ="ARMA(1,1)"
seleccion_6(4,1) = "ARMA(1,2)"
seleccion_6(5,1) = "MA(2)"

seleccion_6(1,2) = "AIC"
seleccion_6(1,3) = "SC"

'Estimamos  y guardamos los principales estadisticos: 
equation eq1_1.ls gtasa c ma(1)
seleccion_6(2,2) =@aic
seleccion_6(2,3)=@sc

equation eq2_1.ls gtasa c ar(1) ma(1)
seleccion_6(3,2) =@aic
seleccion_6(3,3)=@sc

equation eq3_1.ls gtasa c ar(1) ma(1) ma(2)
seleccion_6(4,2) =@aic
seleccion_6(4,3)=@sc

equation eq4_1.ls gtasa c ma(1) ma(2)
seleccion_6(5,2) =@aic
seleccion_6(5,3)=@sc


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
show Seleccion_6

'1.7)Para gtasa4
'Creamos una tabla para almacenar los coeficientes:
table(8,3) Seleccion_7
setcolwidth(seleccion_7, 1, 20) 

seleccion_7(1,1) = "Model"
seleccion_7(2,1) = "AR(1)"
seleccion_7(3,1) = "ARMA(1,1)"
seleccion_7(4,1) = "ARMA(2,1)"
seleccion_7(5,1) = "ARMA(3,1)"

seleccion_7(1,2) = "AIC"
seleccion_7(1,3) = "SC"

'Estimamos  y guardamos los principales estadisticos: 
equation eq1_2.ls gtasa4  c ar(1) 
seleccion_7(2,2) =@aic
seleccion_7(2,3)=@sc

equation eq2_2.ls gtasa4 c ar(1) ma(1)
seleccion_7(3,2) =@aic
seleccion_7(3,3)=@sc

equation eq3_2.ls gtasa4  c ar(1) ar(2) ma(1) 
seleccion_7(4,2) =@aic
seleccion_7(4,3)=@sc

equation eq4_2.ls gtasa4  c ar(1) ar(3) ma(1)
seleccion_7(5,2) =@aic
seleccion_7(5,3)=@sc


'Generamos los residuos de los modelos :
eq1_2.resids(g)  
eq1_2.makeresids eq1_2resids
eq1_2resids.correl

eq2_2.resids(g)
eq2_2.makeresids eq2_2resids
eq2_2resids.correl

eq3_2.resids(g)
eq3_2.makeresids eq3_2resids
eq3_2resids.correl

eq4_2.resids(g)
eq4_2.makeresids eq4_2resids
eq4_2resids.correl

' C) Diagnóstico: evaluamos los errores de la estimacion. 
show Seleccion_7


