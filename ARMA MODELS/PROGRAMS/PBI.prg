'***************************************************************************************
'PC2'
'PREGUNTA 1 SERIE PBI REAL
'***************************************************************************************
cd "C:\Ana\CATO\2020-2\ECONOMETRIA 2\PC-2\pregunta 1\programs final"

'Abrimos nuestra base
import(page=Trimestrales1) "PBI.xlsx" range="Hoja1" @freq Q 1993

'A) Inspeccionamos la serie
series ln_pbi=log(pbi)
freeze(graf1)ln_pbi.line

'Desestacionalizamos
ln_pbi.x13(save="d11", tf=log, arimasmpl="1993Q1 2019Q4")  @x11()
rename ln_pbi_d11 lnpbi_sa
freeze(graf2) lnpbi_sa.line
rename lnpbi_sa lnpbi


'Transformamos la serie en diferencias
series gpbi= lnpbi - lnpbi(-1)
series gpbi4= lnpbi - lnpbi(-4)

'¿La serie es estacionaria?
lnpbi.uroot(lagmethod=maic)
lnpbi.uroot(exog=trend, dfgls, lagmethod=maic)
'No rechaza la H0. Tiene raíz unitaria; por lo tanto, no es estacionaria. 
gpbi.uroot(lagmethod=maic)
'Rechaza la H0 a un 99%. Es decir, no tiene raiz unitaria. Por lo tanto, es estacionaria. 
gpbi4.uroot(lagmethod=maic)
gpbi4.uroot( dfgls, lagmethod=maic)
'ADF: Rechaza la H0 a un 90%. Por lo tanto, es estacionaria bajo ese nivel de critical value.

'Calculamos ACF y PACF
lnpbi.correl(35)
'Por el correlograma, podemos ver que aparentemente la autocorrelación entra en la banda de confianza recien en el lag 32, es decir, aproximadamente en 8 años. Lo que sugiere que la serie es persistente. No podremos modelar un ARMA para arreglar dicha autocorrelación. 
gpbi.correl(12)
'Es estacionaria y al parecer se puede modelar con un ARMA(2,2)
gpbi4.correl(12)
'Es estacionaria y al parecer se puede modelar con un ARMA (4,2)

'Metodología Box-Jekins

'A) Estimacion: estimamos los modelos previamente seleccionados en la etapa anterior. 
'1.1)Para gpbi
'Creamos una tabla para almacenar los coeficientes:
table(8,3) GPBI_Table
setcolwidth(GPBI_Table, 1, 20) 'numero máximo de caracteres 20

GPBI_Table(1,1) = "Model"
GPBI_Table(2,1) = "AR(1)"
GPBI_Table(3,1) = "ARMA(3,4)"
GPBI_Table(4,1) = "ARMA(2,2)"
GPBI_Table(5,1) = "ARMA(4,4)"

GPBI_Table(1,2) = "AIC"
GPBI_Table(1,3) = "SC"

'Estimamos y guardamos los principales estadisticos: 
equation eq1_1.ls gpbi  c ar(1) 
GPBI_Table(2,2) =@aic
GPBI_Table(2,3)=@sc

equation eq2_1.ls gpbi  c ar(1) ar(2) ar(3) ma(4)
GPBI_Table(3,2) =@aic
GPBI_Table(3,3)=@sc

equation eq3_1.ls gpbi  c ar(1) ar(2) ma(1) ma(2)
GPBI_Table(4,2) =@aic
GPBI_Table(4,3)=@sc

equation eq4_1.ls gpbi  c ar(1) ar(2) ar(3) ar(4) ma(1) ma(2) ma(3) ma(4)
GPBI_Table(5,2) =@aic
GPBI_Table(5,3)=@sc

'Según la tabla presentada bajos los criterio AIC Y SC, de los posibles modelos seleccionados, el mejor es el ARMA(3,4). 



'Para corroborrar, si dichos modelos solucionan la correlación de los residuos, los generamos :
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

'Según, los correlogramas mostrados, el modelo que mejor corrige las correlaciones de los residuos son el arma(4.4) y arma(3,4), pero dado que el primero tiene una raíz de 1 y otra muy próxima a salir del círculo unitario, escogemos el modelo arma(3,4). Este no corre este riesgo de presentar raíz unitaria. 

' C) Diagnóstico: evaluamos los errores de la estimacion. 
show GPBI_Table

'1.2)Para gpbi4
'Creamos una tabla para almacenar los coeficientes:
table(8,3) GPBI4_Table
setcolwidth(GPBI4_Table, 1, 20) 'numero máximo de caracteres 20

GPBI4_Table(1,1) = "Model"
GPBI4_Table(2,1) = "ARMA(2,2)"
GPBI4_Table(3,1) = "ARMA(3,4)"
GPBI4_Table(4,1) = "ARMA(3,2)"
GPBI4_Table(5,1) = "ARMA(4,2)"

GPBI4_Table(1,2) = "AIC"
GPBI4_Table(1,3) = "SC"

'Estimamos y guardamos los principales estadisticos: 

equation eq1_4.ls gpbi  c ar(1 to 2)  ma(1 to 2)
GPBI4_Table(2,2) =@aic
GPBI4_Table(2,3)=@sc
'ar(1) no es significativo 

equation eq2_4.ls gpbi  c ar(1) ar(2) ar(3)  ma(4)
GPBI4_Table(3,2) =@aic
GPBI4_Table(3,3)=@sc
'ar(1), ar(3) y ma(1) no son significativos. R2 10

equation eq3_4.ls gpbi  c ar(1) ar(2) ar(3)  ma(1) ma(2) 
GPBI4_Table(4,2) =@aic
GPBI4_Table(4,3)=@sc
'La mayoría no son significativas. 

equation eq4_4.ls gpbi  c ar(1) ar(2) ar(3) ar(4) ma(1) ma(2) 
GPBI4_Table(5,2) =@aic
GPBI4_Table(5,3)=@sc
'ar(2) ar(3) ma(2) no son significativos. Se molestan entre ellos. 

'Según la tabla presentada bajos los criterio AIC Y SC, de los posibles modelos seleccionados, el mejor es el ARMA(3,4). 

eq1_4.resids(g)  
eq1_4.makeresids eq1_4resids
eq1_4resids.correl
'menos 
eq2_4.resids(g)
eq2_4.makeresids eq2_4resids
eq2_4resids.correl
'menos
eq3_4.resids(g)
eq3_4.makeresids eq3_4resids
eq3_4resids.correl
'menos
eq4_4.resids(g)
eq4_4.makeresids eq4_4resids
eq4_4resids.correl
'menos

'Corrigen casi perdectamente el problema de correlación.

' OJO: La serie tiene grandes picos; es decir, tenemos que definir variables dummys para que capturen dichos picos. De lo contrario, estos valores outliers podrían hacer parecer que la serie es estacionaria o más estacionaria de lo que realmente es. 

'Según, los correlogramas mostrados, el modelo que mejor corrige las correlaciones de los residuos son el arma(4,2). Además, es el mejor modelo según el criterio AIC. Sin embargo, dado a la poca significancia de sus dependientes, se recomedaría usar 2 variables dummys que controlen los valores atípicos y usar un ma(2), el cual a la vez es preferido según el criterio SC.

' C) Diagnóstico: evaluamos los errores de la estimacion. 
show GPBI4_Table


