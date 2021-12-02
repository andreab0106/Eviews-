'Pregunta 4 PC2 2020-2
cd "C:\Users\Usuario\Documents\8vociclo\metria2\2020-2\PCS\PC2"
''-------------------------------------------PREGUNTA 4.1 -----------------------------------------'''
'Primero, importamos la data
import(link) "C:\Users\Usuario\Documents\8vociclo\metria2\2020-2\PCS\PC2\data_nelson_plosser (1).xls" range=Hoja1 colhead=1 na="#N/A" @freq A @id @date(series01) @destid @date @smpl @all

'Le sacamos logaritmos
for %i consumer_prices_index employment gnp_deflator industrial_production money_stock nominal_gnp real_gnp real_per_capita_gnp real_wages sp500 unemployment_rate velocity wages

series ln_{%i}=log({%i})

next

'Como ya está en ln procedemos a graficar
for %i consumer_prices_index employment gnp_deflator industrial_production money_stock  nominal_gnp  real_gnp real_per_capita_gnp real_wages sp500 unemployment_rate velocity wages

freeze(graf_ln_{%i})ln_{%i}.line
next

'bond_yield
freeze(graf_bond_yield) bond_yield.line

''-------------------------------------------PREGUNTA 4.2 -----------------------------------------'''

'Como la series es anual no podemos desestacionalizar 

'Correlograma: Obtenemos la autocorrelacion (ACF) y autocorrelacion parcial (PACF).

for %i consumer_prices_index employment gnp_deflator industrial_production money_stock  nominal_gnp  real_gnp real_per_capita_gnp real_wages sp500 unemployment_rate velocity wages

freeze(FA_ln_{%i})ln_{%i}.correl(40)
next

'bond_yield
freeze(FA_bond_yield)bond_yield.correl(40)

'''ACF-BOND YIELD '''
'la autocorrelacion cae lentamente con una forma de escalera. Tuvieron que pasar 9 años para que pueda entrar a la banda de confianza y y luego pasaron 4 años y volvió a salir pero por  el otro lado (el lado izquierdo). Luego, vuelve a entrar a la banda de confianza en el rezago 31 y logra manternse allí hasta el final.Es una serie extremadamente persistente. 

 ''ACF-CONSUMER_PRICES_INDEX''
''la autocorrelacion cae lentamente con una forma de escalera. Recién en el rezago 25 pudo entrar a la banda de confianza y luego pudo mantenerse allí hasta el final.

''ACF-EMPLOYMENT''
''la autocorrelacion cae lentamente con una forma de escalera. Recién en el rezago 21 pudo entrar a la banda de confianza y se mantuvo allí hasta el final.Solo que en el rezago 28 la autocorrelacion sale por el otro lado ,es decir, por el lado izquierdo

''ACF-GNP_DEFLATOR
''la autocorrelacion cae lentamente con una forma de escalera. Recién en el rezago 18 pudo entrar a la banda de confianza y se mantuvo allí hasta el final.Solo que en el rezago 25 la autocorrelacion sale por el otro lado ,es decir, por el lado izquierdo

''ACF-INDUSTRIAL_PRODUCTION''
''la autocorrelacion cae poco a poco. Recién en el rezago 29 pudo entrar a la banda de confianza y se mantuvo allí hasta el final.

''ACF-MONEY_STOCK''
''la autocorrelacion cae poco a poco. Recién en el rezago 22 pudo entrar a la banda de confianza y se mantuvo allí hasta el final.Solo que en el rezago 29 la autocorrelacion sale por el otro lado ,es decir, por el lado izquierdo

''ACF-NOMINAL_GNP''
''la autocorrelacion cae lentamente. Recién en el rezago 15 pudo entrar a la banda de confianza y se mantuvo allí hasta el rezago 27.Luego, se desvió totalmente de la banda de confianza

''ACF-REAL_GNP''
''la autocorrelacion cae lentamente. Recién en el rezago 15 pudo entrar a la banda de confianza y se mantuvo allí hasta el rezago 26. .Luego, se salió totalmente de la banda de confianza

''ACF-REAL_PER_CAPITA_GNP''
''la autocorrelacion cae lentamente. Recién en el rezago 16 pudo entrar a la banda de confianza y se mantuvo allí hasta el rezago 26. .Luego, se salió totalmente de la banda de confianza

''ACF-REAL_WAGES''
''la autocorrelacion cae lentamente. Recién en el rezago 19 pudo entrar a la banda de confianza y se mantuvo allí hasta el rezago 32. .Luego, se desvió totalmente de la banda de confianza

''ACF-SP500''
''la autocorrelacion cae lentamente. Recién en el rezago 21 pudo entrar a la banda de confianza y se mantuvo allí hasta el rezago final.

''ACF-UNEMPLOYMENT_RATE''
'la autocorrelacion cae . Recién en el rezago 4 pudo entrar a la banda de confianza y se mantuvo allí hasta el rezago 9. .Luego, se salió totalmente de la banda de confianza hasta el rezago 13 y volvió a entrar.Después, salió y entró y así unas veces más.

''ACF-VELOCITY''
''la autocorrelacion cae poco a poco. Recién en el rezago 24 pudo entrar a la banda de confianza y se mantuvo allí hasta el final.Solo que en el rezago 35 la autocorrelacion sale por el otro lado ,es decir, por el lado izquierdo

''ACF-WAGES''
'la autocorrelacion cae . Recién en el rezago 17 pudo entrar a la banda de confianza y se mantuvo allí hasta el rezago 36.Luego, se desvió de la banda de confianza totalmente.


''''''''''Comparación con la tabla de Nelson y Plosser (19992)''''''''''''''''''''''''

'Para ello, creamos una tabla 16x9
table(16,9)table_1
'pongo un título
table_1.title Table2-Nelson y Plosser (1982)
'primera columna
table_1(1,1) = " "
table_1(2,1) = "Series"
table_1(3,1) = "Real GNP "
table_1(4,1) = " Nominal GNP"
table_1(5,1) = " Real per capita GNP "
table_1(6,1) = " Industrial production"
table_1(7,1) = " Employment"
table_1(8,1) = " Unemplyment rate "
table_1(9,1) = " GNP deflator "
table_1(10,1) = " Consumer prices "
table_1(11,1) = " Wages"
table_1(12,1) = " Real wages"
table_1(13,1) = " Money stock "
table_1(14,1) = " Velocity "
table_1(15,1) = " Bond yield "
table_1(16,1) = "  Common stock prices "
'segunda columna
table_1(1,2) = " "
table_1(2,2) ="Period"
table_1(3,2) ="1909-1970 "
table_1(4,2) ="1909-1970 "
table_1(5,2) ="1909-1970  "
table_1(6,2) ="1860-1970 "
table_1(7,2) ="1890-1970 "
table_1(8,2) ="1890-1970 "
table_1(9,2) ="1889-1970 "
table_1(10,2) ="1860-1970 "
table_1(11,2) = "1900-1970 "
table_1(12,2) = "1900-1970 "
table_1(13,2) ="1889-1970 "
table_1(14,2) ="1869-1970 "
table_1(15,2) = "1900-1970 "
table_1(16,2) = "1871-1970 "

'Talla de la muestra
table_1(1,3) = "  "
table_1(2,3) ="T "
table_1(3,3) ="62 "
table_1(4,3) ="62"
table_1(5,3) ="62"
table_1(6,3) ="111 "
table_1(7,3) =" 81"
table_1(8,3) =" 81"
table_1(9,3) ="82"
table_1(10,3) ="111"
table_1(11,3) = "71"
table_1(12,3) = "71"
table_1(13,3) ="82"
table_1(14,3) ="102"
table_1(15,3) = "71"
table_1(16,3) = "100"

table_1.setmerge(r1c4:r1c9)
table_1(1,4) = " Sample autocorrelations "
'table_1(1,5) = "  "
'table_1(1,6) = "  "
'table_1(1,7) = "  "
'table_1(1,8) = "  "
'table_1(1,9) = "  "


'ri es el rezago de orden i
table_1(2,4)="r1"
table_1(2,5)="r2"
table_1(2,6)="r3"
table_1(2,7)="r4"
table_1(2,8)="r5"
table_1(2,9)="r6"

'Los 6 rezagos para real GNP
table_1(3,4)=fa_ln_real_gnp(7,4)
table_1(3,5)=fa_ln_real_gnp(8,4)
table_1(3,6)=fa_ln_real_gnp(9,4)
table_1(3,7)=fa_ln_real_gnp(10,4)
table_1(3,8)=fa_ln_real_gnp(11,4)
table_1(3,9)=fa_ln_real_gnp(12,4)

'Los 6 rezagos para nominal GNP
table_1(4,4)=fa_ln_nominal_gnp(7,4)
table_1(4,5)=fa_ln_nominal_gnp(8,4)
table_1(4,6)=fa_ln_nominal_gnp(9,4)
table_1(4,7)=fa_ln_nominal_gnp(10,4)
table_1(4,8)=fa_ln_nominal_gnp(11,4)
table_1(4,9)=fa_ln_nominal_gnp(12,4)

'Los 6 rezagos para real per capita GNP
table_1(5,4)=fa_ln_real_per_capita_gnp(7,4)
table_1(5,5)=fa_ln_real_per_capita_gnp(8,4)
table_1(5,6)=fa_ln_real_per_capita_gnp(9,4)
table_1(5,7)=fa_ln_real_per_capita_gnp(10,4)
table_1(5,8)=fa_ln_real_per_capita_gnp(11,4)
table_1(5,9)=fa_ln_real_per_capita_gnp(12,4)

'Los 6 rezagos para industrial production 
table_1(6,4)=fa_ln_industrial_production(7,4)
table_1(6,5)=fa_ln_industrial_production(8,4)
table_1(6,6)=fa_ln_industrial_production(9,4)
table_1(6,7)=fa_ln_industrial_production(10,4)
table_1(6,8)=fa_ln_industrial_production(11,4)
table_1(6,9)=fa_ln_industrial_production(12,4)

'Los 6 rezagos para employment
table_1(7,4)=fa_ln_employment(7,4)
table_1(7,5)=fa_ln_employment(8,4)
table_1(7,6)=fa_ln_employment(9,4)
table_1(7,7)=fa_ln_employment(10,4)
table_1(7,8)=fa_ln_employment(11,4)
table_1(7,9)=fa_ln_employment(12,4)

'Los 6 rezagos para unemployment rate
table_1(8,4)=fa_ln_unemployment_rate(7,4)
table_1(8,5)=fa_ln_unemployment_rate(8,4)
table_1(8,6)=fa_ln_unemployment_rate(9,4)
table_1(8,7)=fa_ln_unemployment_rate(10,4)
table_1(8,8)=fa_ln_unemployment_rate(11,4)
table_1(8,9)=fa_ln_unemployment_rate(12,4)

'Los 6 rezagos para GNP deflator
table_1(9,4)=fa_ln_gnp_deflator(7,4)
table_1(9,5)=fa_ln_gnp_deflator(8,4)
table_1(9,6)=fa_ln_gnp_deflator(9,4)
table_1(9,7)=fa_ln_gnp_deflator(10,4)
table_1(9,8)=fa_ln_gnp_deflator(11,4)
table_1(9,9)=fa_ln_gnp_deflator(12,4)


'Los 6 rezagos para consumer prices
table_1(10,4)=fa_ln_consumer_prices_index(7,4)
table_1(10,5)=fa_ln_consumer_prices_index(8,4)
table_1(10,6)=fa_ln_consumer_prices_index(9,4)
table_1(10,7)=fa_ln_consumer_prices_index(10,4)
table_1(10,8)=fa_ln_consumer_prices_index(11,4)
table_1(10,9)=fa_ln_consumer_prices_index(12,4)

'Los 6 rezagos para wages
table_1(11,4)=fa_ln_wages(7,4)
table_1(11,5)=fa_ln_wages(8,4)
table_1(11,6)=fa_ln_wages(9,4)
table_1(11,7)=fa_ln_wages(10,4)
table_1(11,8)=fa_ln_wages(11,4)
table_1(11,9)=fa_ln_wages(12,4)

'Los 6 rezagos para real wages
table_1(12,4)=fa_ln_real_wages(7,4)
table_1(12,5)=fa_ln_real_wages(8,4)
table_1(12,6)=fa_ln_real_wages(9,4)
table_1(12,7)=fa_ln_real_wages(10,4)
table_1(12,8)=fa_ln_real_wages(11,4)
table_1(12,9)=fa_ln_real_wages(12,4)

'Los 6 rezagos para money stock
table_1(13,4)=fa_ln_money_stock(7,4)
table_1(13,5)=fa_ln_money_stock(8,4)
table_1(13,6)=fa_ln_money_stock(9,4)
table_1(13,7)=fa_ln_money_stock(10,4)
table_1(13,8)=fa_ln_money_stock(11,4)
table_1(13,9)=fa_ln_money_stock(12,4)

'Los 6 rezagos para velocity
table_1(14,4)=fa_ln_velocity(7,4)
table_1(14,5)=fa_ln_velocity(8,4)
table_1(14,6)=fa_ln_velocity(9,4)
table_1(14,7)=fa_ln_velocity(10,4)
table_1(14,8)=fa_ln_velocity(11,4)
table_1(14,9)=fa_ln_velocity(12,4)

'Los 6 rezagos para bond yield 
table_1(15,4)=fa_bond_yield(7,4)
table_1(15,5)=fa_bond_yield(8,4)
table_1(15,6)=fa_bond_yield(9,4)
table_1(15,7)=fa_bond_yield(10,4)
table_1(15,8)=fa_bond_yield(11,4)
table_1(15,9)=fa_bond_yield(12,4)

'Los 6 rezagos para common stock prices (sp500)
table_1(16,4)=fa_ln_sp500(7,4)
table_1(16,5)=fa_ln_sp500(8,4)
table_1(16,6)=fa_ln_sp500(9,4)
table_1(16,7)=fa_ln_sp500(10,4)
table_1(16,8)=fa_ln_sp500(11,4)
table_1(16,9)=fa_ln_sp500(12,4)


''-------------------------------------------PREGUNTA 4.3 -----------------------------------------'''
'''Modelo original
'y_t= delta+delta1*t ´phi*y_t-1+ v_t 

'estimo los 3 modelos que me piden para todas las series

'Según talla de muestras 
'Talla=62 (real gnp, nominal gnp, real per capita gnp)

for %a nominal_gnp  real_gnp real_per_capita_gnp 
'modelo con tendencia deterministica(phi=0)
equation ln_{%a}_1.ls ln_{%a} c  1/100*@trend(1909:1)
'modelo ar(1) con drift (delta1=0)
equation ln_{%a}_2.ls ln_{%a} c  ln_{%a}(-1) 
'modelo ar(1) con drift y tendencia determinística
equation ln_{%a}_3.ls ln_{%a} c  1/100*@trend(1909:1)  ln_{%a}(-1) 

next

'' T2=71 (wages,real wages, bond yield)
for %b real_wages wages

'modelo con tendencia deterministica(phi=0)
equation ln_{%b}_1.ls ln_{%b} c 1/100*@trend(1900:1)
'modelo ar(1) con drift (delta1=0)
equation ln_{%b}_2.ls ln_{%b} c  ln_{%b}(-1) 
'modelo ar(1) con drift y tendencia determinística
equation ln_{%b}_3.ls ln_{%b} c  1/100*@trend(1900:1)  ln_{%b}(-1) 

next

'bond_ yield'
'modelo con tendencia deterministica(phi=0)
equation bond_yield_1.ls bond_yield c 1/100*@trend(1900:1)
'modelo ar(1) con drift (delta1=0)
equation bond_yield_2.ls bond_yield c bond_yield(-1) 
'modelo ar(1) con drift y tendencia determinística
equation bond_yield_3.ls bond_yield c  1/100*@trend(1900:1) bond_yield(-1) 

''T3=81 (employment y unemployment rate)

for %d  employment unemployment_rate 
'modelo con tendencia deterministica(phi=0)
equation ln_{%d}_1.ls ln_{%d} c 1/100*@trend(1890:1)
'modelo ar(1) con drift (delta1=0)
equation ln_{%d}_2.ls ln_{%d} c  ln_{%d}(-1) 
'modelo ar(1) con drift y tendencia determinística
equation ln_{%d}_3.ls ln_{%d} c  1/100*@trend(1890:1)  ln_{%d}(-1) 

next

' T4=82 (gnp deflator y money stock)
for %m gnp_deflator money_stock  
'modelo con tendencia deterministica(phi=0)
equation ln_{%m }_1.ls ln_{%m } c 1/100*@trend(1889:1)
'modelo ar(1) con drift (delta1=0)
equation ln_{%m }_2.ls ln_{%m } c  ln_{%m }(-1) 
'modelo ar(1) con drift y tendencia determinística
equation ln_{%m }_3.ls ln_{%m } c  1/100*@trend(1889:1) ln_{%m}(-1) 

next
' T5=100 ( sp500)

'modelo con tendencia deterministica(phi=0)
equation ln_sp500_1.ls ln_sp500 c 1/100*@trend(1871:1)
'modelo ar(1) con drift (delta1=0)
equation ln_sp500_2.ls ln_sp500 c  ln_sp500(-1) 
'modelo ar(1) con drift y tendencia determinística
equation ln_sp500_3.ls ln_sp500 c  1/100*@trend(1871:1)  ln_sp500(-1) 

'T6=102(velocity)

'modelo con tendencia deterministica(phi=0)
equation ln_velocity_1.ls ln_velocity c 1/100*@trend(1869:1)
'modelo ar(1) con drift (delta1=0)
equation ln_velocity_2.ls ln_velocity c  ln_velocity(-1) 
'modelo ar(1) con drift y tendencia determinística
equation ln_velocity_3.ls ln_velocity c 1/100*@trend(1869:1)  ln_velocity(-1) 

'T7=111 ( industrial production y consumer prices index)

for %p  consumer_prices_index  industrial_production 
'modelo con tendencia deterministica(phi=0)
equation ln_{%p}_1.ls ln_{%p} c 1/100*@trend(1860:1)
'modelo ar(1) con drift (delta1=0)
equation ln_{%p}_2.ls ln_{%p} c  ln_{%p}(-1) 
'modelo ar(1) con drift y tendencia determinística
equation ln_{%p}_3.ls ln_{%p} c  1/100*@trend(1860:1)  ln_{%p}(-1) 

next

'--------Comparo con tabla 16.1 del libro de Harris----------------------------
'Para ello, creamos una tabla 16x8
table(16,8)table_2
'pongo un título
table_2.title Table16.1- Harris
''primera columna
table_2(1,1) = "Variable "
table_2(2,1) = " "
table_2(3,1) = "Real GNP "
table_2(4,1) = " Nominal GNP"
table_2(5,1) = " Real per capita GNP "
table_2(6,1) = " Industrial production"
table_2(7,1) = " Employment"
table_2(8,1) = " Unemplyment rate "
table_2(9,1) = " GNP deflator "
table_2(10,1) = " Consumer prices "
table_2(11,1) = " Wages"
table_2(12,1) = " Real wages"
table_2(13,1) = " Money stock "
table_2(14,1) = " Velocity "
table_2(15,1) = " Bond yield "
table_2(16,1) = "  Common stock prices "
'segunda fila
table_2.setmerge(r1c2:r1c3)
table_2(1,2) = " Deterministic"
table_2.setmerge(r1c4:r1c5)
table_2(1,4) = " Stocasthic"
table_2.setmerge(r1c6:r1c8)
table_2(1,6) = " Combined"

' parámetros estimados
table_2(2,2) ="beta0"
table_2(2,3) ="beta1 "
table_2(2,4)="delta"
table_2(2,5)="phi"
table_2(2,6)="delta"
table_2(2,7)="gamma"
table_2(2,8)="phi"

'3 modelos de real GNP
table_2(3,2) =ln_real_gnp_1.@coefs(1)
table_2(3,3)=ln_real_gnp_1.@coefs(2)
table_2(3,4)=ln_real_gnp_2.@coefs(1)
table_2(3,5)=ln_real_gnp_2.@coefs(2)
table_2(3,6)=ln_real_gnp_3.@coefs(1)
table_2(3,7)=ln_real_gnp_3.@coefs(2)
table_2(3,8)=ln_real_gnp_3.@coefs(3)

'3 modelos de nominal GNP
table_2(4,2)=ln_nominal_gnp_1.@coefs(1)
table_2(4,3)=ln_nominal_gnp_1.@coefs(2)
table_2(4,4)=ln_nominal_gnp_2.@coefs(1)
table_2(4,5)=ln_nominal_gnp_2.@coefs(2)
table_2(4,6)=ln_nominal_gnp_3.@coefs(1)
table_2(4,7)=ln_nominal_gnp_3.@coefs(2)
table_2(4,8)=ln_nominal_gnp_3.@coefs(3)

'3 modelos de real per capita GNP
table_2(5,2)=ln_real_per_capita_gnp_1.@coefs(1)
table_2(5,3)=ln_real_per_capita_gnp_1.@coefs(2)
table_2(5,4)=ln_real_per_capita_gnp_2.@coefs(1)
table_2(5,5)=ln_real_per_capita_gnp_2.@coefs(2)
table_2(5,6)=ln_real_per_capita_gnp_3.@coefs(1)
table_2(5,7)=ln_real_per_capita_gnp_3.@coefs(2)
table_2(5,8)=ln_real_per_capita_gnp_3.@coefs(3)

'3 modelos de industrial production 
table_2(6,2)=ln_industrial_production_1.@coefs(1)
table_2(6,3)=ln_industrial_production_1.@coefs(2)
table_2(6,4)=ln_industrial_production_2.@coefs(1)
table_2(6,5)=ln_industrial_production_2.@coefs(2)
table_2(6,6)=ln_industrial_production_3.@coefs(1)
table_2(6,7)=ln_industrial_production_3.@coefs(2)
table_2(6,8)=ln_industrial_production_3.@coefs(3)

'3 modelos de employment
table_2(7,2)=ln_employment_1.@coefs(1)
table_2(7,3)=ln_employment_1.@coefs(2)
table_2(7,4)=ln_employment_2.@coefs(1)
table_2(7,5)=ln_employment_2.@coefs(2)
table_2(7,6)=ln_employment_3.@coefs(1)
table_2(7,7)=ln_employment_3.@coefs(2)
table_2(7,8)=ln_employment_3.@coefs(3)

'3 modelos de unemployment rate
table_2(8,2)=ln_unemployment_rate_1.@coefs(1)
table_2(8,3)=ln_unemployment_rate_1.@coefs(2)
table_2(8,4)=ln_unemployment_rate_2.@coefs(1)
table_2(8,5)=ln_unemployment_rate_2.@coefs(2)
table_2(8,6)=ln_unemployment_rate_3.@coefs(1)
table_2(8,7)=ln_unemployment_rate_3.@coefs(2)
table_2(8,8)=ln_unemployment_rate_3.@coefs(3)

'3 modelos de GNP deflator
table_2(9,2)=ln_gnp_deflator_1.@coefs(1)
table_2(9,3)=ln_gnp_deflator_1.@coefs(2)
table_2(9,4)=ln_gnp_deflator_2.@coefs(1)
table_2(9,5)=ln_gnp_deflator_2.@coefs(2)
table_2(9,6)=ln_gnp_deflator_3.@coefs(1)
table_2(9,7)=ln_gnp_deflator_3.@coefs(2)
table_2(9,8)=ln_gnp_deflator_3.@coefs(3)

'3 modelos de consumer prices
table_2(10,2)=ln_consumer_prices_index_1.@coefs(1)
table_2(10,3)=ln_consumer_prices_index_1.@coefs(2)
table_2(10,4)=ln_consumer_prices_index_2.@coefs(1)
table_2(10,5)=ln_consumer_prices_index_2.@coefs(2)
table_2(10,6)=ln_consumer_prices_index_3.@coefs(1)
table_2(10,7)=ln_consumer_prices_index_3.@coefs(2)
table_2(10,8)=ln_consumer_prices_index_3.@coefs(3)

'3 modelos de wages
table_2(11,2)=ln_wages_1.@coefs(1)
table_2(11,3)=ln_wages_1.@coefs(2)
table_2(11,4)=ln_wages_2.@coefs(1)
table_2(11,5)=ln_wages_2.@coefs(2)
table_2(11,6)=ln_wages_3.@coefs(1)
table_2(11,7)=ln_wages_3.@coefs(2)
table_2(11,8)=ln_wages_3.@coefs(3)

'3 modelos de real wages
table_2(12,2)=ln_real_wages_1.@coefs(1)
table_2(12,3)=ln_real_wages_1.@coefs(2)
table_2(12,4)=ln_real_wages_2.@coefs(1)
table_2(12,5)=ln_real_wages_2.@coefs(2)
table_2(12,6)=ln_real_wages_3.@coefs(1)
table_2(12,7)=ln_real_wages_3.@coefs(2)
table_2(12,8)=ln_real_wages_3.@coefs(3)

'3 modelos de money stock
table_2(13,2)=ln_money_stock_1.@coefs(1)
table_2(13,3)=ln_money_stock_1.@coefs(2)
table_2(13,4)=ln_money_stock_2.@coefs(1)
table_2(13,5)=ln_money_stock_2.@coefs(2)
table_2(13,6)=ln_money_stock_3.@coefs(1)
table_2(13,7)=ln_money_stock_3.@coefs(2)
table_2(13,8)=ln_money_stock_3.@coefs(3)

'3 modelos de velocity
table_2(14,2)=ln_velocity_1.@coefs(1)
table_2(14,3)=ln_velocity_1.@coefs(2)
table_2(14,4)=ln_velocity_2.@coefs(1)
table_2(14,5)=ln_velocity_2.@coefs(2)
table_2(14,6)=ln_velocity_3.@coefs(1)
table_2(14,7)=ln_velocity_3.@coefs(2)
table_2(14,8)=ln_velocity_3.@coefs(3)

'3 modelos de bond yield 
table_2(15,2)=bond_yield_1.@coefs(1)
table_2(15,3)=bond_yield_1.@coefs(2)
table_2(15,4)=bond_yield_2.@coefs(1)
table_2(15,5)=bond_yield_2.@coefs(2)
table_2(15,6)=bond_yield_3.@coefs(1)
table_2(15,7)=bond_yield_3.@coefs(2)
table_2(15,8)=bond_yield_3.@coefs(3)

'3 modelos de common stock prices (sp500)
table_2(16,2)=ln_sp500_1.@coefs(1)
table_2(16,3)=ln_sp500_1.@coefs(2)
table_2(16,4)=ln_sp500_2.@coefs(1)
table_2(16,5)=ln_sp500_2.@coefs(2)
table_2(16,6)=ln_sp500_3.@coefs(1)
table_2(16,7)=ln_sp500_3.@coefs(2)
table_2(16,8)=ln_sp500_3.@coefs(3)

'OBSERVACIÓn: Se divide entre 100 porque Harris lo hace en su libro .

'''''''''''''Replicamos la tabla 9'''''''''''''''
'Para ello, creamos una tabla 16x8
table(15,11)table_3
'pongo un título
table_3.title Table9- Nelson y Posser
table_3(1,1) = "Variable "
table_3(2,1) = "Real GNP "
table_3(3,1) = " Nominal GNP"
table_3(4,1) = " Real per capita GNP "
table_3(5,1) = " Industrial production"
table_3(6,1) = " Employment"
table_3(7,1) = " Unemplyment rate "
table_3(8,1) = " GNP deflator "
table_3(9,1) = " Consumer prices "
table_3(10,1) = " Wages"
table_3(11,1) = " Real wages"
table_3(12,1) = " Money stock "
table_3(13,1) = " Velocity "
table_3(14,1) = " Bond yield "
table_3(15,1) = "  Common stock prices "
'segunda columna
table_3(1,2) ="T "
table_3(2,2) ="62 "
table_3(3,2) ="62"
table_3(4,2) ="62"
table_3(5,2) ="111 "
table_3(6,2) =" 81"
table_3(7,2) =" 81"
table_3(8,2) ="82"
table_3(9,2) ="111"
table_3(10,2) = "71"
table_3(11,2) = "71"
table_3(12,2) ="82"
table_3(13,2) ="102"
table_3(14,2) = "71"
table_3(15,2) = "100"

'tercera columna
table_3(1,3) ="k "
table_3(2,3) ="2 "
table_3(3,3) ="2"
table_3(4,3) ="2"
table_3(5,3) ="6 "
table_3(6,3) =" 3"
table_3(7,3) =" 4"
table_3(8,3) ="2"
table_3(9,3) ="4"
table_3(10,3) = "3"
table_3(11,3) = "2"
table_3(12,3) ="2"
table_3(13,3) ="1"
table_3(14,3) = "3"
table_3(15,3) = "3"

'' parámetros estimados
table_3(1,4)="mu"
table_3(1,5) ="t(mu)"
table_3(1,6) ="gamma "
table_3(1,7)="t(gamma)"
table_3(1,8)="rho1"
table_3(1,9)="t(rho1)"
table_3(1,10)="s(mu)"
table_3(1,11)="r1"

'-----------------------------Interpretación de resultados--------------------------------
''''-----Para el bond yield----------''''
 'modelo con tendencia deterministica(phi=0)
'la tendencia no es significativa y la constante sí lo es al 99%. Se encuentra un r cuadrado muy bajo, que nos diria que las variables exógenas no explican casi nada la variable endógena. El criterio de akaike es 2.79 y el criterio de schwarz es 2.85. El log likelihood es -97.

'modelo ar(1) con drift (delta1=0)
' La constante no es significativa y la varible rezagada de orden 1 es significativa al 99%. Con un r2 cuadrado muy alto, las variables exógenas explican muy bien la endógena.El criterio de akaike es 0.43 y el criterio de schwarz es 0.49. El log likelihood es -13.

'modelo ar(1) con drift y tendencia determinística
'La constante y la tendencia son significativos al 95% y la varible rezagada de orden 1 es significativa al 99%. Con un r2 cuadrado muy alto, las variables exógenas explican muy bien la endógena.El criterio de akaike es 0.38y el criterio de schwarz es 0.47.. El log likelihood es -10.4.



''''-----Para consumer prices index----------''''
 '''modelo con tendencia determinsitica(phi=0)''
' La constante y la tendencia son significativas al 99%. Con un r2 cuadrado regular, las variables exógenas explican bien la endógena.El criterio de akaike es 0.22 y el criterio de schwarz es 0.27. El log likelihood es -10.5.

''''modelo ar(1) con drift (delta1=0)'''
' La constante no es significativa y la varible rezagada de orden 1 es significativa al 99%. Con un r2 cuadrado demasiado alto, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -2.85 y el criterio de schwarz es -2.80. El log likelihood es 159.2.

'modelo ar(1) con drift y tendencia determinística
'' La constante y la tendencia no son significativas y la varible rezagada de orden 1 es significativa al 99%. Con un r2 cuadrado demasiado alto, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -2.86 y el criterio de schwarz es -2.78. El log likelihood es 160.


''''-----Para employment----------''''
'''modelo con tendencia determinsitica(phi=0)''
' La constante y la tendencia son significativas al 99%. Con un r2 cuadrado alto, las variables exógenas explican muy bien la endógena.El criterio de akaike es -2.11 y el criterio de schwarz es -2.05. El log likelihood es 87.5.

'modelo ar(1) con drift (delta1=0)
' La constante no es significativa y la varible rezagada de orden 1 es significativa al 99%. Con un r2 cuadrado demasiado alto, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -3.659 y el criterio de schwarz es -3.60. El log likelihood es 148.38.

'modelo ar(1) con drift y tendencia determinística
' La constante y la tendencia es significativa al 95% y la varible rezagada de orden 1 es significativa al 99%. Con un r2 cuadrado demasiado alto, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -3.68 y el criterio de schwarz es -3.59. El log likelihood es 150.45


'''''------Para gnp_deflator------------------------""""
 'modelo con tendencia determinsitica(phi=0)
' La constante  y la tendencia son significativas al 99%. Con un r2 cuadrado alto, las variables exógenas explican muy bien la endógena.El criterio de akaike es-0.84 y el criterio de schwarz es -0.78. El log likelihood es 36.7.

'modelo ar(1) con drift (delta1=0)
' La constante no es significativa y la varible rezagada de orden 1 es significativa al 99% . Con un r2 cuadrado casi iugal a 1, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -3.03 y el criterio de schwarz es -2.97. El log likelihood es 125.03.

'modelo ar(1) con drift y tendencia determinística
' La constante y la tendencia son significativas al 95%  y la variable rezagada de orden 1 son significativas al 99%. Con un r2 cuadrado casi uno, las variables exógenas explican casi de manera perfecta la endógena.El criterio de akaike es -3.07y el criterio de schwarz es -2.98. El log likelihood es 127.42.


'''''------Para industrial production------------------------""""
 'modelo con tendencia determinsitica(phi=0)
' La constante no es significativa y la tendencia sí lo es al 99%. Con un r2 cuadrado muy alto, las variables exógenas explican muy bien la endógena.El criterio de akaike es -0.55 y el criterio de schwarz es -051. El log likelihood es 33.05.

'modelo ar(1) con drift (delta1=0)
'La constante y la varible rezagada de orden 1 son significativas al 99% . Con un r2 cuadrado casi iugal a 1, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -1.72 y el criterio de schwarz es -1.67. El log likelihood es 96.65.

'modelo ar(1) con drift y tendencia determinística
'La constante,la tendencia  y la variable rezagada de orden 1 son significativas al 99%. Con un r2 cuadrado casi uno, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -1.78 y el criterio de schwarz es -1.71. El log likelihood es 101.13.


'''''------Para  money stock------------------------""""
 'modelo con tendencia determinsitica(phi=0)
' La constante  y la tendencia son significativas al 99%. Con un r2 cuadrado muy alto, las variables exógenas explican muy bien la endógena.El criterio de akaike es -0.42 y el criterio de schwarz es-0.36. El log likelihood es 19.07

'modelo ar(1) con drift (delta1=0)
'La constante y la varible rezagada de orden 1 son significativas al 99% . Con un r2 cuadrado casi iugal a 1, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -2.692 y el criterio de schwarz es -2.63. El log likelihood es111.04

'modelo ar(1) con drift y tendencia determinística
'La tendencia no es significativa, la constante  y la variable rezagada de orden 1 son significativas al 99%. Con un r2 cuadrado casi uno, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -2.691 y el criterio de schwarz es -2.60. El log likelihood es 112.018.


'''''------Para  nominal gnp------------------------""""
 'modelo con tendencia determinsitica(phi=0)
' La constante  y la tendencia son significativas al 99%. Con un r2 cuadrado relativamente alto, las variables exógenas explican muy bien la endógena.El criterio de akaike es 0.22  y el criterio de schwarz es 0.28. El log likelihood es      -4.8.

'modelo ar(1) con drift (delta1=0)
'La constante no es significativa y la varible rezagada de orden 1 es significativa al 99% . Con un r2 cuadrado casi iugal a 1, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -1.75 y el criterio de schwarz es-1.68. El log likelihood es 55.5.

'modelo ar(1) con drift y tendencia determinística
''La constante y la tendencia no son significativas,pero la variable rezagada de orden 1 es significativa al 99%. Con un r2 cuadrado casi uno, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -1.76 y el criterio de schwarz es -1.65. El log likelihood es 56.67.


'''''------Para  real gnp ------------------------""""
 'modelo con tendencia determinsitica(phi=0)
 'La constante  y la tendencia son significativas al 99%. Con un r2 cuadrado relativamente alto, las variables exógenas explican bien la endógena.El criterio de akaike es -1.15 y el criterio de schwarz es -1.08. El log likelihood es 37.69.

'modelo ar(1) con drift (delta1=0)
''La constante no es significativa y la varible rezagada de orden 1 es significativa al 99% . Con un r2 cuadrado casi igual a 1, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es - 2.59 y el criterio de schwarz es -2.52. El log likelihood es 81.07.

'modelo ar(1) con drift y tendencia determinística
''La constante y la tendencia son significativas al 95%, pero la variable rezagada de orden 1 son significativas al 99%. Con un r2 cuadrado casi uno, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -2.64 y el criterio de schwarz es -2.53. El log likelihood es 83.42.

'''''------Para  real per capita gnp------------------------""""
 'modelo con tendencia determinsitica(phi=0)
'La constante y la tendencia son significativas al 99%. Con un r2 cuadrado relativamente alto, las variables exógenas explican bien la endógena.El criterio de akaike es -1.16 y el criterio de schwarz es -1.10. El log likelihood es 38.23.

'modelo ar(1) con drift (delta1=0)
''La constante no es significativa y la varible rezagada de orden 1 es significativa al 99% . Con un r2 cuadrado casi igual a 1, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -2.57  y el criterio de schwarz es -2.50. El log likelihood es 80.39.

'modelo ar(1) con drift y tendencia determinística
'La constante y la tendencia son significativas al 95%, pero la variable rezagada de orden 1 es significativa al 99%. Con un r2 cuadrado casi uno, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -2.62 y el criterio de schwarz es -2.58. El log likelihood es 82.96.

'''''------Para  real wages------------------------""""
'modelo con tendencia determinsitica(phi=0)
'La constante  y la tendencia son significativas al 99%. Con un r2 cuadrado relativamente alto, las variables exógenas explican bien la endógena.El criterio de akaike es -2.23 y el criterio de schwarz es -2.16 . El log likelihood es 81.15.

'modelo ar(1) con drift (delta1=0)
''La constante  no es significativa y la variable rezagada de orden 1 es significativa al 99% . Con un r2 cuadrado casi igual a 1, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -3.71  y el criterio de schwarz es -3.65.. El log likelihood es 132.13.

'modelo ar(1) con drift y tendencia determinística
'La constante,la tendencia  y la variable rezagada de orden 1 son significativas al 99%. Con un r2 cuadrado casi uno, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es-3.77 y el criterio de schwarz es -3.67. El log likelihood es 135.08.

'''''------Para  sp500------------------------""""
 'modelo con tendencia determinsitica(phi=0)
'La constante  y la tendencia son significativas al 99%. Con un r2 cuadrado relativamente regular, las variables exógenas explican bien la endógena.El criterio de akaike es 1.02 y el criterio de schwarz es 1.07 . El log likelihood es -49.09

'modelo ar(1) con drift (delta1=0)
''La constante  no es significativa, pero  la variable rezagada de orden 1 es significativa al 99% . Con un r2 cuadrado casi igual a 1, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es -0.78 y el criterio de schwarz es -0.73. El log likelihood es 40.7.

'modelo ar(1) con drift y tendencia determinística
'La constante no es significativa, pero la tendencia  y la variable rezagada de orden 1 son significativas al 98 % y 97%,respectivamente. Con un r2 cuadrado casi uno, las variables exógenas explican demasiado bien la endógena.El criterio de akaike es      -0.81 y el criterio de schwarz es -0.73. El log likelihood es 43.32.


'''''------Para  unemployment rate------------------------""""
 'modelo con tendencia determinsitica(phi=0)
'La constante  es significativa al 99%, pero la tendencia no lo es. Con un r2 cuadrado relativamente bajo , las variables exógenas no explican casi nada sobre la endógena.El criterio de akaike es 2.12 y el criterio de schwarz es 2.18 . El log likelihood es -84.24.

'modelo ar(1) con drift (delta1=0)
''La constante y la variable rezagada de orden 1 son significativas al 99% . Con un r2 cuadrado regular, las variables exógenas explican bien la endógena.El criterio de akaike es 1.31 y el criterio de schwarz es 1.37. El log likelihood es -50.50

'modelo ar(1) con drift y tendencia determinística
'La tendencia no es significativa, pero laconstante y la variable rezagada de orden 1 son significativas al 99 %. Con un r2 cuadrado regular, las variables exógenas explican bien la endógena.El criterio de akaike es 1.33 y el criterio de schwarz es 1.42. El log likelihood es -50.29.


'''''------Para  velocity------------------------""""
 'modelo con tendencia determinsitica(phi=0)
'La constante y la tendencia son significativas al 99%. Con un r2 cuadrado relativamentealto , las variables exógenas explican bien la endógena.El criterio de akaike es -0.43 y el criterio de schwarz es -.0.38 . El log likelihood es 24.18.

'modelo ar(1) con drift (delta1=0)
'La constante no es signifacativa, pero la variable rezagada de orden 1 sí lo es al 99% . Con un r2 cuadrado alto, las variables exógenas explican muy bien la endógena.El criterio de akaike es-2.55 y el criterio de schwarz es -2.49. El log likelihood es 130.79.

'modelo ar(1) con drift y tendencia determinística
'La tendencia y la constante no son significativas, pero la variable rezagada de orden 1 es significativa al 99 %. Con un r2 cuadrado regular, las variables exógenas explican bien la endógena.El criterio de akaike es -2.53 y el criterio de schwarz es       -2.45. El log likelihood es 131.06.


'''''------Para  wages------------------------""""
 'modelo con tendencia determinsitica(phi=0)
'La constante y la tendencia son significativas al 99%. Con un r2 cuadrado relativamente alto , las variables exógenas explican bien la endógena.El criterio de akaike es -0.43 y el criterio de schwarz es -0.37 . El log likelihood es 17.4

'modelo ar(1) con drift (delta1=0)
'La constante no es signifacativa, pero la variable rezagada de orden 1 sí lo es al 99% . Con un r2 cuadrado alto, las variables exógenas explican muy bien la endógena.El criterio de akaike es -2.49 y el criterio de schwarz es -2.43. El log likelihood es 89.34.

'modelo ar(1) con drift y tendencia determinística
'La tendencia y la constante no son significativas, pero la variable rezagada de orden 1 es significativa al 99 %. Con un r2 cuadrado alto, las variables exógenas explican muy bien la endógena.El criterio de akaike es -2.503 y el criterio de schwarz es            -2.41. El log likelihood es 90.6.


''''''---------------------------------------PREGUNTA 4.4---------------------------------------------'''
' Simular el siguiente proceso
'y_t = 0.1 + 0.2* t + v_t
for %i  consumer_prices_index employment gnp_deflator industrial_production money_stock  nominal_gnp  real_gnp real_per_capita_gnp real_wages sp500 unemployment_rate velocity wages
'deterministico
series s1_det_{%i}=ln_{%i}
series s1_det_{%i}=0.1+0.2*@trend+ nrnd
freeze(s1_det{%i})s1_det_{%i}.correl(12)

next

'bond_yield
series s1_det_bond_yield=bond_yield
series s1_det_bond_yield=0.1+0.2*@trend+ nrnd
freeze(s1_detbond_yield)s1_det_bond_yield.correl(12)




''''''---------------------------------------PREGUNTA 4.5 -------------------------------------------'''
' Simular el siguiente proceso
'y_t = 0.3 + y_t(-1) + v_t
for %w  consumer_prices_index employment gnp_deflator industrial_production money_stock  nominal_gnp  real_gnp real_per_capita_gnp real_wages sp500 unemployment_rate velocity wages

'estocástico
series s2_estoc_{%w}=ln_{%w}
series s3_estoc_{%w}=ln_{%w}(-1)
series s2_estoc_{%w}=0.3+s3_estoc_{%w}+ nrnd
freeze(s2_estoc{%w})s2_estoc_{%w}.correl(12)

next

'bond_yield
series s2_estoc_bond_yield=bond_yield
series s3_estoc_bond_yield=bond_yield(-1)
series s2_estoc_bond_yield=0.3+s3_estoc_bond_yield+ nrnd
freeze(s2_estocbond_yield)s2_estoc_bond_yield.correl(12)


