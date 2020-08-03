//1. with n_hp_sale    --- one inteaction term
use "C:\Users\wills\Desktop\Heat Pump Paper\Data-Post-treatment\matched data-with n_hp_sale.dta"

reg logprice_adjusted treatment T_N yearbuilt-landassessedvalue_persqft n_hp_sale i.year i.city_id [iweight=weight]
/////////////////////////////////////////////////////////////////////////////////////////////////////
      Source |       SS           df       MS      Number of obs   =   299,054
-------------+----------------------------------   F(1202, 297851) =    107.38
       Model |    94352.99     1,202  78.4966639   Prob > F        =    0.0000
    Residual |  217727.793   297,851  .730995676   R-squared       =    0.3023
-------------+----------------------------------   Adj R-squared   =    0.2995
       Total |  312080.783   299,053  1.04356346   Root MSE        =    .85498

-------------------------------------------------------------------------------------------
        logprice_adjusted |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------------+----------------------------------------------------------------
                treatment |    .190954   .0052204    36.58   0.000     .1807221    .2011859
                      T_N |  -.0003865   .0000277   -13.97   0.000    -.0004408   -.0003323
                yearbuilt |   .0064739   .0000785    82.45   0.000       .00632    .0066278
              noofstories |   .0623359   .0027944    22.31   0.000     .0568589    .0678129
               totalrooms |   .0196515   .0007659    25.66   0.000     .0181504    .0211526
            totalbedrooms |   .1202176   .0016657    72.17   0.000     .1169528    .1234823
                     area |   3.65e-06   1.38e-07    26.37   0.000     3.38e-06    3.92e-06
landassessedvalue_persqft |   .0000577   .0000202     2.86   0.004     .0000182    .0000972
                n_hp_sale |   .0004192   .0000293    14.32   0.000     .0003618    .0004765
                          |
                     year |
                    2017  |   .0069516   .0035428     1.96   0.050     7.81e-06    .0138954
                    2018  |   .0178438   .0053572     3.33   0.001     .0073438    .0283438
                          |
                  city_id |

                    _cons |  -.6767648   .1664364    -4.07   0.000    -1.002975   -.3505541
-------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////

//2.add control -- n_quarterly_total_trans
use "C:\Users\wills\Desktop\Heat Pump Paper\Data-Post-treatment\matched data-with n_hp_sale and n_trans.dta"

reg logprice_adjusted treatment T_N yearbuilt-landassessedvalue_persqft n_hp_sale n_total_tran i.year i.city_id [iweight=weight]
/////////////////////////////////////////////////////////////////////////////////////////////////////
      Source |       SS           df       MS      Number of obs   =   288,654
-------------+----------------------------------   F(1187, 287466) =    112.98
       Model |  90559.7265     1,187  76.2929457   Prob > F        =    0.0000
    Residual |  194118.271   287,466  .675273844   R-squared       =    0.3181
-------------+----------------------------------   Adj R-squared   =    0.3153
       Total |  284677.997   288,653  .986229131   Root MSE        =    .82175

-------------------------------------------------------------------------------------------
        logprice_adjusted |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------------+----------------------------------------------------------------
                treatment |   .1848309   .0051129    36.15   0.000     .1748096    .1948521
                      T_N |  -.0003688    .000027   -13.67   0.000    -.0004217    -.000316
                yearbuilt |   .0063868   .0000775    82.44   0.000      .006235    .0065387
              noofstories |   .0596897   .0027175    21.96   0.000     .0543635     .065016
               totalrooms |   .0452135   .0008259    54.74   0.000     .0435948    .0468323
            totalbedrooms |   .0983446   .0017015    57.80   0.000     .0950097    .1016796
                     area |   3.31e-06   1.34e-07    24.71   0.000     3.05e-06    3.58e-06
landassessedvalue_persqft |   .0000449   .0000196     2.30   0.022     6.61e-06    .0000832
                n_hp_sale |   .0004377   .0000291    15.05   0.000     .0003807    .0004948
             n_total_tran |   1.29e-06   2.60e-06     0.50   0.619    -3.81e-06    6.40e-06
                          |
                     year |
                    2017  |   .0141208   .0034853     4.05   0.000     .0072896    .0209519
                    2018  |   .0164512   .0057291     2.87   0.004     .0052223    .0276801
                          |
                  city_id |
                          |
                    _cons |  -.1907684   .4388275    -0.43   0.664    -1.050858    .6693213
-------------------------------------------------------------------------------------------
///////////////////////////////////////////////////////////////////////////////////////////////////////

//3. many dummies
centile n_hp_sale, centile(10 20 30 40 50 60 70 80 90)

gen n1=1 if n_hp_sale<11
gen n2=1 if n_hp_sale<24&n_hp_sale>=11
gen n3=1 if n_hp_sale<43&n_hp_sale>=24
gen n4=1 if n_hp_sale<72&n_hp_sale>=43
gen n5=1 if n_hp_sale<110&n_hp_sale>=72
gen n6=1 if n_hp_sale<156&n_hp_sale>=110
gen n7=1 if n_hp_sale<228&n_hp_sale>=156
gen n8=1 if n_hp_sale<336&n_hp_sale>=228
gen n9=1 if n_hp_sale<621&n_hp_sale>=336
gen n10=1 if n_hp_sale>=621

foreach n in 1 2 3 4 5 6 7 8 9 10{
replace n`n'=0 if n`n'==.
}

foreach n in 1 2 3 4 5 6 7 8 9 10{
gen T_n`n'=treatment*n`n'
}


reg logprice_adjusted T_n1-T_n10 yearbuilt-landassessedvalue_persqft n_hp_sale n_total_tran i.year i.city_id [iweight=weight]
////////////////////////////////////////////////////////////////////////////////////////////////////

      Source |       SS           df       MS      Number of obs   =   288,654
-------------+----------------------------------   F(1195, 287458) =    112.17
       Model |  90530.3972     1,195  75.7576546   Prob > F        =    0.0000
    Residual |    194147.6   287,458  .675394667   R-squared       =    0.3180
-------------+----------------------------------   Adj R-squared   =    0.3152
       Total |  284677.997   288,653  .986229131   Root MSE        =    .82182

-------------------------------------------------------------------------------------------
        logprice_adjusted |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------------+----------------------------------------------------------------
                     T_n1 |   .1745917   .0085807    20.35   0.000     .1577738    .1914096
                     T_n2 |   .1841225   .0079072    23.29   0.000     .1686245    .1996204
                     T_n3 |   .1659257   .0081565    20.34   0.000     .1499391    .1819123
                     T_n4 |   .1346407   .0084215    15.99   0.000     .1181347    .1511467
                     T_n5 |   .1469148   .0082045    17.91   0.000     .1308343    .1629954
                     T_n6 |   .1510075   .0077945    19.37   0.000     .1357305    .1662844
                     T_n7 |   .0994919   .0078191    12.72   0.000     .0841667    .1148172
                     T_n8 |   .0761549   .0082957     9.18   0.000     .0598957    .0924142
                     T_n9 |   .1273491   .0098646    12.91   0.000     .1080147    .1466835
                    T_n10 |    .100945   .0169173     5.97   0.000     .0677875    .1341025
                yearbuilt |   .0063783   .0000775    82.31   0.000     .0062264    .0065302
              noofstories |   .0598588   .0027178    22.02   0.000      .054532    .0651857
               totalrooms |   .0451483   .0008261    54.66   0.000     .0435293    .0467674
            totalbedrooms |   .0982815   .0017017    57.75   0.000     .0949462    .1016169
                     area |   3.31e-06   1.34e-07    24.67   0.000     3.05e-06    3.57e-06
landassessedvalue_persqft |   .0000447   .0000196     2.29   0.022     6.38e-06     .000083
                n_hp_sale |   .0000903   .0000138     6.53   0.000     .0000632    .0001174
             n_total_tran |   2.83e-06   2.62e-06     1.08   0.279    -2.30e-06    7.97e-06
                          |
                     year |
                    2017  |   .0147375   .0035061     4.20   0.000     .0078657    .0216093
                    2018  |   .0132462   .0057543     2.30   0.021      .001968    .0245245
                          |
                  city_id |

                    _cons |   -.147453   .4390514    -0.34   0.737    -1.007981    .7130755
-------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////



//4.add another interaction --- T_NT=treatment* nTrans
gen T_NT=treatment*n_total_tran
reg logprice_adjusted treatment T_N T_NT yearbuilt-landassessedvalue_persqft n_hp_sale n_total_tran i.year i.city_id [iweight=weight]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      Source |       SS           df       MS      Number of obs   =   288,654
-------------+----------------------------------   F(1188, 287465) =    113.22
       Model |  90742.9369     1,188  76.3829435   Prob > F        =    0.0000
    Residual |   193935.06   287,465  .674638862   R-squared       =    0.3188
-------------+----------------------------------   Adj R-squared   =    0.3159
       Total |  284677.997   288,653  .986229131   Root MSE        =    .82136

-------------------------------------------------------------------------------------------
        logprice_adjusted |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
--------------------------+----------------------------------------------------------------
                treatment |   .1558424   .0054048    28.83   0.000     .1452491    .1664357
                      T_N |  -.0004888   .0000279   -17.50   0.000    -.0005435    -.000434
                     T_NT |   .0000265   1.61e-06    16.48   0.000     .0000233    .0000296
                yearbuilt |   .0064405   .0000775    83.10   0.000     .0062886    .0065924
              noofstories |   .0596321   .0027163    21.95   0.000     .0543083    .0649559
               totalrooms |    .045291   .0008255    54.86   0.000      .043673     .046909
            totalbedrooms |   .0984359   .0017008    57.88   0.000     .0951024    .1017693
                     area |   3.22e-06   1.34e-07    23.97   0.000     2.95e-06    3.48e-06
landassessedvalue_persqft |    .000045   .0000195     2.30   0.021     6.73e-06    .0000833
                n_hp_sale |   .0005415   .0000298    18.20   0.000     .0004832    .0005998
             n_total_tran |  -.0000174   2.84e-06    -6.13   0.000     -.000023   -.0000118
                          |
                     year |
                    2017  |   .0147013   .0034839     4.22   0.000      .007873    .0215296
                    2018  |     .01795   .0057271     3.13   0.002     .0067249     .029175
                          |
                  city_id |
                    
                          |
                    _cons |  -.2802434   .4386547    -0.64   0.523    -1.139995    .5795077
-------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//5. the share of hp sale
//2016-2018 quarterly for each city in our matched sample.
//1674 city,35 states
. sum n_hp_sale,detail

                          n_hp_sale
-------------------------------------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0       Obs              18,414
25%            0              0       Sum of Wgt.      18,414

50%            1                      Mean            16.8745
                        Largest       Std. Dev.      64.40025
75%           10           1700
90%           35           1715       Variance       4147.392
95%           78           1897       Skewness       13.52639
99%          262           2116       Kurtosis       289.4212

. sum share_hp,detail

                          share_hp
-------------------------------------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0       Obs              18,414
25%            0              0       Sum of Wgt.      18,414

50%     .0106001                      Mean           .0788638
                        Largest       Std. Dev.      .1381007
75%           .1              1
90%     .2592593              1       Variance       .0190718
95%     .3813131              1       Skewness       2.579373
99%     .6363636              1       Kurtosis         10.791

. sum n_total_tran,detail

                        n_total_tran
-------------------------------------------------------------
      Percentiles      Smallest
 1%            6              1
 5%           16              1
10%           26              1       Obs              10,230
25%           52              1       Sum of Wgt.      10,230

50%          121                      Mean           403.2605
                        Largest       Std. Dev.      1108.221
75%          324          20456
90%          860          21246       Variance        1228154
95%         1485          22136       Skewness       9.278381
99%         5151          23222       Kurtosis        126.537

// the obs of n_total_tran is smaller than the other two, becuase we did not collect the quarterly data in the city when there was no heat-pump house sold.
//It does not influence the calculation of the share of n_hp_sale.





