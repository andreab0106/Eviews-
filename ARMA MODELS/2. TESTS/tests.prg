'*******************************************************************************************
'PC2'
'PREGUNTA 1
'*******************************************************************************************
cd "C:\Users\andre\OneDrive\Documents\GitHub\Eviews-\DATA"

'Abrimos nuestras bases
import(page=Trimestrales1) "PBI.xlsx" range="Hoja1" @freq Q 1993

import(page=Trimestrales2) "ipc.TRIM1999.xlsx" range="Hoja1" @freq Q 1999

import(page=Trimestrales3) "M3.trim.xlsx" range="Sheet1" @freq Q 1986

import(page=Trimestrales4) "tasa_de_referencia_TRIM_3.xlsx" range="Sheet1" @freq Q 2001


'******************ANALIZANDO UN MODELO************
'*********************  AR(2) Y AR(4)************************
'************************************************************
'---------Tasa de crecimiento anual PBI, AR(2)-------
pageselect Trimestrales1
series ln_pbi=log(pbi)
freeze(graf1)ln_pbi.line

pageselect Trimestrales1
ln_pbi.x13(save="d11", tf=log, arimasmpl="1995Q1 2015Q4")  @x11()
rename ln_pbi_d11 lnpbi_sa
freeze(graf2) lnpbi_sa.line
rename lnpbi_sa lnpbi

pageselect Trimestrales1
series gpbi4= lnpbi - lnpbi(-4)
equation eq_gpbi4.ls gpbi4 c ar(2)
eq_gpbi4.arma(t)
eq_gpbi4.arma
'Las constantes son significativas individualmente y en su conjunto. 
'Las raíces son 0.65 y -0.65.
'Estan dentro del círculo unitario; por lo tanto, es estacionario. 

'---------------- lnPBI, AR(2) ------------
pageselect Trimestrales1
equation eq_lnpbi.ls lnpbi c ar(1) ar(2) @trend
eq_lnpbi.arma(t)
eq_lnpbi.arma
'Recordar que la serie no es estacionaria. En realidad, es persistente. 
'Las dependientes son significativas individual y conjuntamente. 
'Con la estimación del modelo, las raíces son 0.81 y 0.21. Estan dentro del cículo unitario. Por lo tanto, se podría decir que es estacionaria. Sin embargo, por la persistencia de la serie. Este modelo no corrgie la correlación de los residuos. 

equation eq_lnpbi1.ls lnpbi c  lnpbi(-1) lnpbi(-2) @trend
eq_lnpbi1.auto(15)
'Efectivamente los errores están correlacionados

eq_lnpbi1.auto(15)
'--------------Tasa de interés, AR(4)-----------
pageselect Trimestrales4
equation eq_tasa.ls tasa c ar(1) ar(2) ar(3) ar(4) 
eq_tasa.arma
eq_tasa.arma(t)
'El AR(4) no es significativo. 
'Las raíces invertidas: 0.78 0.71 0.14-0.50i 0.14+0.50i
'Estan dentro del círculo unitario. Por lo tanto, es estacionario. 

'*******************TEST DE WALD Y TEST DE LR*********************
'*********************************************************
'  ++++++++++++++ARMA(1,1)++++++++++++++++
'-------------------- TASA DE INTERÉS -------------------

pageselect Trimestrales4
tasa.uroot
equation eq4_4.ls tasa  c ar(1) ma(1)
'No corrige correctamente la correlación de residuos 
eq4_4.arma
'Test de Wald
eq4_4.wald c(1)=0
'Se rechaza la H0 (pvalue es 0.000); por lo tanto, ar(1) es significativo, por lo que es correcto modelar la serie con ar(1). 

eq4_4.wald c(2)=0
'Se rechaza la H0 (pvalue es 0.000); por lo tanto, ma(1) es significativo, por lo que es correcto modelar la serie con ma(1).

eq4_4.wald c(2)=0, c(3)=c(2)
'Se rechaza la H0 (pvalue es 0.000); por lo tanto, ar(1) y ma(1) son significativas, por lo que es correcto estimar la serie con un modelo arma(1,1).
 
'Test LR 
eq4_4.testdrop ar(1) ma(1)
'Rechaza H0 (Pvalue=.000). Por lo tanto, ar(1) y ma(1) no son insignificantes conjuntamente, por lo que no son redudantes dentro de la estimación

'--------------------- INFLACIÓN ANUAL   ---------------------
pageselect Trimestrales2
series ln_ipc=log(ipc)
ln_ipc.x13(save="d11", tf=log, arimasmpl="1999Q1 2019Q4")  @x11()
rename ln_ipc_d11 lnipc_sa
freeze(graf2) lnipc_sa.line
renaze lnipc_sa lnipc

'Generamos la inflación
pageselect Trimestrales2
series gipc4= lnipc - lnipc(-4)
freeze(graf1)lnipc.line
'Estudiamos estacionariedad
gipc4.uroot(adf, exog= trend, info=maic)
'Rechazamos hiótesis nula a 90%. Por lo tanto, no tiene raiz unitaria. 
equation eq_infla.ls gipc4 c ar(1) ma(1) 
'No corrige la correlación de los residuos 
eq_infla.arma
series u=nrnd
 equation eq_infla1.ls gipc4 c gipc4(-1) u u(-1)
eq_infla1.auto(15)
'Ya no hay autocorrelación de errores 

'Test de Wald 
eq_infla.wald  c(1)=0
'Se rechaza la H0 (pvalue es 0.000); por lo tanto, ar(1) es significativo, por lo que es correcto modelar la serie con ar(1). 

eq_infla.wald  c(2)=0
'Se rechaza la H0 (pvalue es 0.000); por lo tanto, ma(1) es significativo, por lo que es correcto modelar la serie con ma(1).

eq_infla.wald  c(2)=0, c(3)=c(2)
'Se rechaza la H0 (pvalue es 0.000); por lo tanto, ar(1) y ma(1) son significativas, por lo que es correcto estimar la serie con un modelo arma(1,1).

'Test LR
eq_infla.testdrop ar(1) ma(1) 
'Rechaza H0 (Pvalue=.000). Por lo tanto, ar(1) y ma(1) no son insignificantes conjuntamente, por lo que no son redudantes dentro de la estimación.

'----------------   TASA DE CRECIMIENTO ANUAL PBI --------------------

pageselect Trimestrales1
equation eq_gpbi41.ls gpbi4 c ar(1) ma(1)
'No corrige correlación de los residuos. 
eq_gpbi41.arma
'Dentro del cículo unitario; por lo tanto, es estacionaria. 

'Test de Wald 
eq_gpbi41.wald c(2)=0
'Se rechaza la H0 (pvalue es 0.000); por lo tanto, ar(1) es significativo, por lo que es correcto modelar la serie con ar(1)

eq_gpbi41.wald c(3)=0
'Se rechaza la H0 (pvalue es 0.000); por lo tanto, ma(1) es significativo, por lo que es correcto modelar la serie con ma(1).

eq_gpbi41.wald c(2)=0, c(3)=c(2)
'Se rechaza la H0 (pvalue es 0.000); por lo tanto, ar(1) y ma(1) son significativas, por lo que es correcto estimar la serie con un modelo arma(1,1)

'Test LR
eq_gpbi41.testdrop ar(1) ma(1)
'Rechaza H0 (Pvalue=.000). Por lo tanto, ar(1) y ma(1) no son insignificantes conjuntamente, por lo que no son redudantes dentro de la estimación


