τ_bc = 1.0
Eshift_bc=0.0
Ev_bc=Inf
#### LV chamber parameters #### Checked
v0_lv_bc = 5.0*1.5
p0_lv_bc = 1.0
Emin_lv_bc = 0.1
Emax_lv_bc = 2.5*1.75
τes_lv_bc = 0.3
τed_lv_bc = 0.45
Eshift_lv_bc = 0.0
#### RV Chamber parameters #### Checked
v0_rv_bc = 10.0
p0_rv_bc = 1.0
Emin_rv_bc = 0.1
Emax_rv_bc = 1.15*1.1
τes_rv_bc = 0.3
τed_rv_bc = 0.45
Eshift_rv_bc = 0.0
### LA Atrium Parameters #### Checked
v0_la_bc = 4.0*0.75
p0_la_bc = 1.0
Emin_la_bc = 0.15
Emax_la_bc = 0.25
τpwb_la_bc = 0.92
τpww_la_bc = 0.09
τes_la_bc = τpww_la/2
τed_la_bc = τpww_la
Eshift_la_bc = τpwb_la
### RA Atrium parameters #### Checked
v0_ra_bc = 4.0*0.5
p0_ra_bc = 1.0
Emin_ra_bc = 0.15
Emax_ra_bc = 0.25
τpwb_ra_bc = 0.92
τpww_ra_bc = 0.09
τes_ra_bc = τpww_ra/2
τed_ra_bc = τpww_ra
Eshift_ra_bc = τpwb_ra
#### Valve parameters #### Checked
CQ_AV_bc = 350.0
CQ_MV_bc = 400.0
CQ_TV_bc = 400.0
CQ_PV_bc = 350.0
## Systemic Aortic Sinus #### Checked
Csas_bc = 0.08*0.375
Rsas_bc = 0.003*16
Lsas_bc = (6.2e-5)*4
pt0sas_bc = 100.0
qt0sas_bc = 0.0
## Systemic Artery #### Checked
Csat_bc = 1.6
Rsat_bc = 0.05
Lsat_bc = 0.0017
pt0sat_bc = 100.0
qt0sat_bc = 0.0
## Systemic Arteriole #### Checked
Rsar_bc = 0.5
## Systemic Capillary #### Checked 
Rscp_bc = 0.52
## Systemic Vein #### Checked
Csvn_bc = (20.5*0.95)+(20.5*0.05*3*0.614)
Rsvn_bc = (0.075*0.995)+(0.075*0.005*1.916)
pt0svn_bc = 0.0
qt0svn_bc = 0.0
## Pulmonary Aortic Sinus #### Checked
Cpas_bc = 0.18*0.611
Rpas_bc = 0.002*8.352
Lpas_bc = (5.2e-5)*2.89
pt0pas_bc = 30.0
qt0pas_bc = 0.0
## Pulmonary Artery #### Checked
Cpat_bc = 3.8
Rpat_bc = 0.01
Lpat_bc = 0.0017
pt0pat_bc = 30.0
qt0pat_bc = 0.0
## Pulmonary Arteriole #### Checked
Rpar_bc = 0.05
## Pulmonary Capillary #### Checked
Rpcp_bc = 0.25
## Pulmonary Vein #### Checked
Cpvn_bc = 20.5
Rpvn_bc = 0.006           # this was 0.006 originally and in the paper, seems to be wrong in the paper!
# CHANGED THIS IN THE CELLML MODEL AS WELL TO MATCH THE PAPER!!!!!
pt0pvn_bc = 0.0
qt0pvn_bc = 0.0
## KG diaphragm ## Not in cellML model
# left heart #
Kst_la_bc = 2.5
Kst_lv_bc = 20.0
Kf_sav_bc = 0.0004
Ke_sav_bc = 9000.0
M_sav_bc = 0.0004
A_sav_bc = 0.00047
# right heart # 
Kst_ra_bc = 2.5
Kst_rv_bc = 20.0
Kf_pav_bc = 0.0004
Ke_pav_bc = 9000.0
M_pav_bc = 0.0004
A_pav_bc = 0.00047
#
#### Diff valve params #### not in cellML model
Kp_av_bc = 5500.0 # *  57.29578 # Shi Paper has values in radians!
Kf_av_bc = 50.0
Kf_mv_bc = 50.0
Kp_mv_bc = 5500.0 # *  57.29578 
Kf_tv_bc = 50.0
Kp_tv_bc = 5500.0 # *  57.29578
Kf_pv_bc = 50.0
Kp_pv_bc = 5500.0 #*  57.29578
Kb_av_bc = 2.0
Kv_av_bc = 7.0
Kb_mv_bc = 2.0
Kv_mv_bc = 3.5
Kb_tv_bc = 2.0
Kv_tv_bc = 3.5
Kb_pv_bc = 2.0
Kv_pv_bc = 3.5
θmax_av_bc = 75.0 * pi / 180
θmax_mv_bc = 75.0 * pi / 180
θmin_av_bc = 5.0 * pi / 180
θmin_mv_bc = 5.0 * pi / 180
θmax_pv_bc = 75.0 * pi / 180
θmax_tv_bc = 75.0 * pi / 180
θmin_pv_bc = 5.0 * pi / 180
θmin_tv_bc = 5.0 * pi / 180

## pressure force and frictional force is the same for all 4 valves 

# Initial conditions #### Checked against cellML model

LV_Vt0_bc = 500
RV_Vt0_bc = 500
LA_Vt0_bc = 20
RA_Vt0_bc = 20

