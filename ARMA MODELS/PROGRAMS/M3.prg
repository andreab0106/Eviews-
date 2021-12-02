'***************************************************************************************
'PC2'
'PREGUNTA 1 SERIE M3
'***************************************************************************************
cd "C:\Ana\CATO\2020-2\ECONOMETRIA 2\PC-2\pregunta 1\programs final"

'Abrimos nuestras bases
import(page=Trimestrales3) "M3.trim.xlsx" range="Sheet1" @freq Q 1986

'A) Inspeccionamos las series
series ln_m3=log(m3)
freeze(graf1)ln_m3.line

'Transformamos las series en diferencias
series gm3= ln_m3 - ln_m3(-1)
series gm34= ln_m3 - ln_m3(-4)

'La serie es estacionaria?
ln_m3.uroot(exog=trend, lagmethod=maic)
'Con el test ADF y lag length modified Akaike la hipotesis nula no se rechaza, por lo que la serie no es estacionaria.
ln_m3.uroot(exog=trend, dfgls, lagmethod=maic)
'también rechaza la hipotesis nula
gm3.uroot(lagmethod=maic)
'El test ADF con intercepto señala que  se rechaza la nula, por lo que es estacionaria
gm34.uroot(lagmethod=maic)
'El test ADF con intercepto da como resultado el rechazo de la hipotesis nula, por lo tanto es estacionaria.

'Calculamos ACF y PACF
ln_m3.correl(40)
 'Según la forma del PACF, la serie se puede modelar como un AR(1)
gm3.correl(20)
' El PACF muestra que el se puede proponer un ARMA(1,1) o un AR(1)
gm34.correl(20)
'El PACF se corta en el  lag 1, por lo que se propone un ARMA(2,1) o ARMA(3,1)
'Metodología Box-Jekins

'1.3.1)Para gm3

'Creamos una tabla para almacenar los coeficientes:
table(8,3) Seleccion_3
setcolwidth(seleccion_3, 1, 20) 

seleccion_3(1,1) = "Model"
seleccion_3(2,1) = "AR(1)"
seleccion_3(3,1) = "ARMA(5,2)"
'según el Automatic ARIMA forecasting
seleccion_3(4,1) = "ARMA(1,1)"
seleccion_3(5,1) = "AR(3)"


seleccion_3(1,2) = "AIC"
seleccion_3(1,3) = "SC"

'Estimamos y guardamos los principales estadisticos: 


equation eq1_1.ls gm3  c ar(1)
seleccion_3(2,2) =@aic
seleccion_3(2,3)=@sc

equation eq2_1.ls gm3 c ar(1) ar(2) ar(3)  ar(4) ar(5) ma(1) ma(2)
seleccion_3(3,2) =@aic
seleccion_3(3,3)=@sc


equation eq3_1.ls gm3  c ar(1) ma(1)
seleccion_3(4,2) =@aic
seleccion_3(4,3)=@sc

equation eq4_1.ls gm3  c ar(1) ar(3) 
seleccion_3(5,2) =@aic
seleccion_3(5,3)=@sc


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
show Seleccion_3

'1.3.2)Para gm34
'Creamos una tabla para almacenar los coeficientes:
table(8,3) Seleccion_4
setcolwidth(seleccion_4, 1, 20) 

seleccion_4(1,1) = "Model"
seleccion_4(2,1) = "ARMA(2,4)"
seleccion_4(3,1) = "ARMA(3,1)"
seleccion_4(4,1) = "ARMA(2,1)"
seleccion_4(5,1) = "ARMA(3,6)"
'según el Automatic ARIMA forecasting

seleccion_4(1,2) = "AIC"
seleccion_4(1,3) = "SC"

'Estimamos y guardamos los principales estadisticos: 


equation eq1_4.ls gm34  c ar(1) ar(2) ma(4)
seleccion_4(2,2) =@aic
seleccion_4(2,3)=@sc

equation eq2_4.ls gm34  c ar(1) ar(2) ar(3) ma(1)
seleccion_4(3,2) =@aic
seleccion_4(3,3)=@sc  

equation eq3_4.ls gm34  c ar(1) ar(2) ma(1)  
seleccion_4(4,2) =@aic
seleccion_4(4,3)=@sc

equation eq4_4.ls gm34  c ar(1) ar(2) ar(3) ma(1) ma(2) ma(3) ma(4) ma(5) ma(6)
seleccion_4(5,2) =@aic
seleccion_4(5,3)=@sc

'Generamos los residuos de los modelos :
eq1_4.resids(g)  
eq1_4.makeresids eq1_4resids
eq1_4resids.correl

eq2_4.resids(g)
eq2_4.makeresids eq2_4resids
eq2_4resids.correl

eq3_4.resids(g)
eq3_4.makeresids eq3_4resids
eq3_4resids.correl

eq4_4.resids(g)
eq4_4.makeresids eq4_4resids
eq4_4resids.correl


' C) Diagnóstico: evaluamos los errores de la estimacion. 
show Seleccion_4

'1.3.2)Para ln_m3
'Creamos una tabla para almacenar los coeficientes:
table(8,3) Seleccion_5
setcolwidth(seleccion_5, 1, 20) 

seleccion_5(1,1) = "Model"
seleccion_5(2,1) = "AR(1)"
seleccion_5(3,1) = "ARMA(1,1)"
seleccion_5(4,1) = "ARMA(2,1)"
seleccion_5(5,1) = "ARMA(3,1)"
'según el Automatic ARIMA forecasting

seleccion_5(1,2) = "AIC"
seleccion_5(1,3) = "SC"

'Estimamos y guardamos los principales estadisticos: 


equation eq1_5.ls gm34  c ar(1)
seleccion_5(2,2) =@aic
seleccion_5(2,3)=@sc


equation eq2_5.ls gm34  c ar(1) ma(1)
seleccion_5(3,2) =@aic
seleccion_5(3,3)=@sc

equation eq3_5.ls gm34  c ar(2) ma(1)
seleccion_5(4,2) =@aic
seleccion_5(4,3)=@sc  

equation eq4_5.ls gm34  c ar(1) ar(2) ar(3) ma(1)
seleccion_5(5,2) =@aic
seleccion_5(5,3)=@sc



'Generamos los residuos de los modelos :
eq1_5.resids(g)  
eq1_5.makeresids eq1_5resids
eq1_5resids.correl

eq2_5.resids(g)
eq2_5.makeresids eq2_5resids
eq2_5resids.correl

eq3_5.resids(g)
eq3_5.makeresids eq3_5resids
eq3_5resids.correl

eq4_5.resids(g)
eq4_5.makeresids eq4_5resids
eq4_5resids.correl


' C) Diagnóstico: evaluamos los errores de la estimacion. 
show Seleccion_5


