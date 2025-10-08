τ_ba = 1.0
Eshift_ba=0.0
Ev_ba=Inf
#### LV chamber parameters #### Checked
v0_lv_ba = 5.0
p0_lv_ba = 1.0
Emin_lv_ba = 0.1
Emax_lv_ba = 2.5*1.75
τes_lv_ba = 0.3
τed_lv_ba = 0.45
Eshift_lv_ba = 0.0
#### RV Chamber parameters #### Checked
v0_rv_ba = 10.0
p0_rv_ba = 1.0
Emin_rv_ba = 0.1
Emax_rv_ba = 1.15*1.1
τes_rv_ba = 0.3
τed_rv_ba = 0.45
Eshift_rv_ba = 0.0
### LA Atrium Parameters #### Checked
v0_la_ba = 4.0
p0_la_ba = 1.0
Emin_la_ba = 0.15
Emax_la_ba = 0.25
τpwb_la_ba = 0.92
τpww_la_ba = 0.09
τes_la_ba = τpww_la/2
τed_la_ba = τpww_la
Eshift_la_ba = τpwb_la
### RA Atrium parameters #### Checked
v0_ra_ba = 4.0*0.75
p0_ra_ba = 1.0
Emin_ra_ba = 0.15
Emax_ra_ba = 0.25
τpwb_ra_ba = 0.92
τpww_ra_ba = 0.09
τes_ra_ba = τpww_ra/2
τed_ra_ba = τpww_ra
Eshift_ra_ba = τpwb_ra
#### Valve parameters #### Checked
CQ_AV_ba = 350.0
CQ_MV_ba = 400.0
CQ_TV_ba = 400.0
CQ_PV_ba = 350.0
## Systemic Aortic Sinus #### Checked
Csas_ba = 0.08*0.375
Rsas_ba = 0.003*16
Lsas_ba = (6.2e-5)*4
pt0sas_ba = 100.0
qt0sas_ba = 0.0
## Systemic Artery #### Checked
Csat_ba = 1.6
Rsat_ba = 0.05
Lsat_ba = 0.0017
pt0sat_ba = 100.0
qt0sat_ba = 0.0
## Systemic Arteriole #### Checked
Rsar_ba = 0.5
## Systemic Capillary #### Checked 
Rscp_ba = 0.52
## Systemic Vein #### Checked
Csvn_ba = 20.5
Rsvn_ba = 0.075
pt0svn_ba = 0.0
qt0svn_ba = 0.0
## Pulmonary Aortic Sinus #### Checked
Cpas_ba = 0.18*0.611
Rpas_ba = 0.002*8.352
Lpas_ba = (5.2e-5)*2.89
pt0pas_ba = 30.0
qt0pas_ba = 0.0
## Pulmonary Artery #### Checked
Cpat_ba = 3.8
Rpat_ba = 0.01
Lpat_ba = 0.0017
pt0pat_ba = 30.0
qt0pat_ba = 0.0
## Pulmonary Arteriole #### Checked
Rpar_ba = 0.05
## Pulmonary Capillary #### Checked
Rpcp_ba = 0.25
## Pulmonary Vein #### Checked
Cpvn_ba = 20.5
Rpvn_ba = 0.006           # this was 0.006 originally and in the paper, seems to be wrong in the paper!
# CHANGED THIS IN THE CELLML MODEL AS WELL TO MATCH THE PAPER!!!!!
pt0pvn_ba = 0.0
qt0pvn_ba = 0.0
## KG diaphragm ## Not in cellML model
# left heart #
Kst_la_ba = 2.5
Kst_lv_ba = 20.0
Kf_sav_ba = 0.0004
Ke_sav_ba = 9000.0
M_sav_ba = 0.0004
A_sav_ba = 0.00047
# right heart # 
Kst_ra_ba = 2.5
Kst_rv_ba = 20.0
Kf_pav_ba = 0.0004
Ke_pav_ba = 9000.0
M_pav_ba = 0.0004
A_pav_ba = 0.00047
#
#### Diff valve params #### not in cellML model
Kp_av_ba = 5500.0 # *  57.29578 # Shi Paper has values in radians!
Kf_av_ba = 50.0
Kf_mv_ba = 50.0
Kp_mv_ba = 5500.0 # *  57.29578 
Kf_tv_ba = 50.0
Kp_tv_ba = 5500.0 # *  57.29578
Kf_pv_ba = 50.0
Kp_pv_ba = 5500.0 #*  57.29578
Kb_av_ba = 2.0
Kv_av_ba = 7.0
Kb_mv_ba = 2.0
Kv_mv_ba = 3.5
Kb_tv_ba = 2.0
Kv_tv_ba = 3.5
Kb_pv_ba = 2.0
Kv_pv_ba = 3.5
θmax_av_ba = 75.0 * pi / 180
θmax_mv_ba = 75.0 * pi / 180
θmin_av_ba = 5.0 * pi / 180
θmin_mv_ba = 5.0 * pi / 180
θmax_pv_ba = 75.0 * pi / 180
θmax_tv_ba = 75.0 * pi / 180
θmin_pv_ba = 5.0 * pi / 180
θmin_tv_ba = 5.0 * pi / 180

## pressure force and frictional force is the same for all 4 valves 

# Initial conditions #### Checked against cellML model

LV_Vt0_ba = 500
RV_Vt0_ba = 500
LA_Vt0_ba = 20
RA_Vt0_ba = 20

