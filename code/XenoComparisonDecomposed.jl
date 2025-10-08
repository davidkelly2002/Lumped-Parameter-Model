using CirculatorySystemModels
using ModelingToolkit
using OrdinaryDiffEq
using Plots

include("ShiParam.jl")

@independent_variables t


function plot_setup(plot_title, x_label, y_label)
    return plot(xlabel=x_label, ylabel=y_label, legend=false, title=plot_title, yguidefontsize=12, ytickfontsize=12, xguidefontsize=12, xtickfontsize=12)
end


plot_title = "(a) Decreased aortic sinus\nradius"

p_rv_pt_ao_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_ao_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_ao_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_ao_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_ao_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_ao_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_ao_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_ao_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_ao_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_ao_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_ao_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_ao_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_ao_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_ao_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_ao_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_ao_r = plot_setup(plot_title, "t (s)", "Volume (ml)");


plot_title = "(b) Decreased aortic sinus\nYoung's modulus"

p_rv_pt_ao_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_ao_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_ao_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_ao_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_ao_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_ao_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_ao_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_ao_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_ao_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_ao_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_ao_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_ao_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_ao_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_ao_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_ao_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_ao_ym = plot_setup(plot_title, "t (s)", "Volume (ml)");

plot_title = "(c) Decreased PA radius"

p_rv_pt_pa_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_pa_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_pa_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_pa_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_pa_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_pa_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_pa_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_pa_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_pa_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_pa_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_pa_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_pa_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_pa_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_pa_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_pa_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_pa_r = plot_setup(plot_title, "t (s)", "Volume (ml)");

plot_title = "(d) Decreased PA Young's\nmodulus"

p_rv_pt_pa_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_pa_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_pa_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_pa_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_pa_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_pa_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_pa_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_pa_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_pa_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_pa_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_pa_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_pa_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_pa_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_pa_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_pa_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_pa_ym = plot_setup(plot_title, "t (s)", "Volume (ml)");

plot_title = "(e) Decreased LA volume"

p_rv_pt_la_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_la_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_la_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_la_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_la_v0 = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_la_v0 = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_la_v0 = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_la_v0 = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_la_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_la_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_la_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_la_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_la_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_la_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_la_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_la_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)");

plot_title = "(f) Decreased RA volume\n(biatrial)"

p_rv_pt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_ra_v0_ba = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_ra_v0_ba = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_ra_v0_ba = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_ra_v0_ba = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_ra_v0_ba = plot_setup(plot_title, "t (s)", "Volume (ml)");

plot_title = "(g) Increased LV elastance"

p_rv_pt_lv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_lv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_lv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_lv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_lv_emax = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_lv_emax = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_lv_emax = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_lv_emax = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_lv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_lv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_lv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_lv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_lv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_lv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_lv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_lv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)");

plot_title = "(h) Increased RV elastance"

p_rv_pt_rv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_rv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_rv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_rv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_rv_emax = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_rv_emax = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_rv_emax = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_rv_emax = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_rv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_rv_emax = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_rv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_rv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_rv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_rv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_rv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_rv_emax = plot_setup(plot_title, "t (s)", "Volume (ml)");

plot_title = "(i) Increased LV volume"

p_rv_pt_lv_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_lv_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_lv_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_lv_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_lv_v0 = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_lv_v0 = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_lv_v0 = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_lv_v0 = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_lv_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_lv_v0 = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_lv_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_lv_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_lv_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_lv_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_lv_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_lv_v0 = plot_setup(plot_title, "t (s)", "Volume (ml)");

plot_title = "(j) Decreased RA volume\n(bicaval)"

p_rv_pt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_ra_v0_bc = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_ra_v0_bc = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_ra_v0_bc = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_ra_v0_bc = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_ra_v0_bc = plot_setup(plot_title, "t (s)", "Volume (ml)");

plot_title = "(k) Decreased VC radius"

p_rv_pt_vc_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_vc_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_vc_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_vc_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_vc_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_vc_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_vc_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_vc_r = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_vc_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_vc_r = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_vc_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_vc_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_vc_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_vc_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_vc_r = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_vc_r = plot_setup(plot_title, "t (s)", "Volume (ml)");

plot_title = "(l) Decreased VC Young's\nmodulus"

p_rv_pt_vc_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_ra_pt_vc_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_pt_vc_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_la_pt_vc_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_rv_pv_vc_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ra_pv_vc_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_lv_pv_vc_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_la_pv_vc_ym = plot_setup(plot_title, "Volume (ml)", "Pressure (mmHg)")
p_ao_pt_vc_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_pa_pt_vc_ym = plot_setup(plot_title, "t (s)", "Pressure (mmHg)")
p_lv_vt_vc_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_rv_vt_vc_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_la_vt_vc_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ra_vt_vc_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_ao_vt_vc_ym = plot_setup(plot_title, "t (s)", "Volume (ml)")
p_pa_vt_vc_ym = plot_setup(plot_title, "t (s)", "Volume (ml)");

###########################
# REFERENCE HEALTHY HUMAN #
###########################
# Heart chambers
@named LV = ShiChamber(V₀=v0_lv, p₀=p0_lv, Eₘᵢₙ=Emin_lv, Eₘₐₓ=Emax_lv, τ=τ, τₑₛ=τes_lv, τₑₚ=τed_lv, Eshift=0.0)
@named LA = ShiChamber(V₀=v0_la, p₀=p0_la, Eₘᵢₙ=Emin_la, Eₘₐₓ=Emax_la, τ=τ, τₑₛ=τpww_la / 2, τₑₚ=τpww_la, Eshift=τpwb_la)
@named RV = ShiChamber(V₀=v0_rv, p₀=p0_rv, Eₘᵢₙ=Emin_rv, Eₘₐₓ=Emax_rv, τ=τ, τₑₛ=τes_rv, τₑₚ=τed_rv, Eshift=0.0)
@named RA = ShiAtrium(V₀=v0_ra, p₀=1, Eₘᵢₙ=Emin_ra, Eₘₐₓ=Emax_ra, τ=τ, τpwb=τpwb_ra, τpww=τpww_ra)

@named AV = OrificeValve(CQ=CQ_AV)
@named MV = OrificeValve(CQ=CQ_MV)
@named TV = OrificeValve(CQ=CQ_TV)
@named PV = OrificeValve(CQ=CQ_PV)

####### Systemic Loop #######
# Systemic Aortic Sinus ##
@named SAS = CRL(C=Csas, R=Rsas, L=Lsas)
# Systemic Artery ##
@named SAT = CRL(C=Csat, R=Rsat, L=Lsat)
# Systemic Arteriole ##
@named SAR = Resistor(R=Rsar)
# Systemic Capillary ##
@named SCP = Resistor(R=Rscp)
# Systemic Vein ##
@named SVN = CR(R=Rsvn, C=Csvn)

####### Pulmonary Loop #######
# Pulmonary Aortic Sinus ##
@named PAS = CRL(C=Cpas, R=Rpas, L=Lpas)
# Pulmonary Artery ##
@named PAT = CRL(C=Cpat, R=Rpat, L=Lpat)
# Pulmonary Arteriole ##
@named PAR = Resistor(R=Rpar)
# Pulmonary Capillary ##
@named PCP = Resistor(R=Rpcp)
# Pulmonary Vein ##
@named PVN = CR(R=Rpvn, C=Cpvn)

##
circ_eqs = [
        connect(LV.out, AV.in)
        connect(AV.out, SAS.in)
        connect(SAS.out, SAT.in)
        connect(SAT.out, SAR.in)
        connect(SAR.out, SCP.in)
        connect(SCP.out, SVN.in)
        connect(SVN.out, RA.in)
        connect(RA.out, TV.in)
        connect(TV.out, RV.in)
        connect(RV.out, PV.in)
        connect(PV.out, PAS.in)
        connect(PAS.out, PAT.in)
        connect(PAT.out, PAR.in)
        connect(PAR.out, PCP.in)
        connect(PCP.out, PVN.in)
        connect(PVN.out, LA.in)
        connect(LA.out, MV.in)
        connect(MV.out, LV.in)
    ]

## Compose the whole ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
        [LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])

## And simplify it
circ_sys = structural_simplify(circ_model)

## Setup ODE
# Initial Conditions for Shi Valve
u0 = [
        LV.V => LV_Vt0
        RV.V => RV_Vt0
        LA.V => LA_Vt0
        RA.V => RA_Vt0
        SAS.C.p => pt0sas
        SAS.L.q => qt0sas
        SAT.C.p => pt0sat
        SAT.L.q => qt0sat
        SVN.C.p => pt0svn
        PAS.C.p => pt0pas
        PAS.L.q => qt0pas
        PAT.C.p => pt0pat
        PAT.L.q => qt0pat
        PVN.C.p => pt0pvn
    ]

prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20);

#########################
# ADD TO GRAPH FUNCTION #
#########################

function add_to_graphs_blue(graph_list)
    plot!(graph_list[1], (sol.t.-19.0), sol[circ_sys.RV.p], linewidth=2, linecolor=:blue)
    plot!(graph_list[2], (sol.t.-19.0), sol[circ_sys.RA.p], linewidth=2, linecolor=:blue)
    plot!(graph_list[3], (sol.t.-19.0), sol[circ_sys.LV.p], linewidth=2, linecolor=:blue)
    plot!(graph_list[4], (sol.t.-19.0), sol[circ_sys.LA.p], linewidth=2, linecolor=:blue)
    plot!(graph_list[5], sol[circ_sys.RV.V], sol[circ_sys.RV.p], linewidth=2, linecolor=:blue)
    plot!(graph_list[6], sol[circ_sys.RA.V], sol[circ_sys.RA.p], linewidth=2, linecolor=:blue)
    plot!(graph_list[7], sol[circ_sys.LV.V], sol[circ_sys.LV.p], linewidth=2, linecolor=:blue)
    plot!(graph_list[8], sol[circ_sys.LA.V], sol[circ_sys.LA.p], linewidth=2, linecolor=:blue)
    plot!(graph_list[9], (sol.t.-19.0), sol[circ_sys.SAS.C.p], linewidth=2, linecolor=:blue)
    plot!(graph_list[10], (sol.t.-19.0), sol[circ_sys.PAS.C.p], linewidth=2, linecolor=:blue)
    plot!(graph_list[11], (sol.t.-19.0), sol[circ_sys.RV.V], linewidth=2, linecolor=:blue)
    plot!(graph_list[12], (sol.t.-19.0), sol[circ_sys.RA.V], linewidth=2, linecolor=:blue)
    plot!(graph_list[13], (sol.t.-19.0), sol[circ_sys.LV.V], linewidth=2, linecolor=:blue)
    plot!(graph_list[14], (sol.t.-19.0), sol[circ_sys.LA.V], linewidth=2, linecolor=:blue)
    plot!(graph_list[15], (sol.t.-19.0), sol[circ_sys.SAS.C.V], linewidth=2, linecolor=:blue)
    plot!(graph_list[16], (sol.t.-19.0), sol[circ_sys.PAS.C.V], linewidth=2, linecolor=:blue)
end



###################################
# ADD REFERENCE CASE TO ALL PLOTS #
###################################

add_to_graphs_blue([p_rv_pt_ao_r, p_ra_pt_ao_r, p_lv_pt_ao_r, p_la_pt_ao_r, p_rv_pv_ao_r, p_ra_pv_ao_r, p_lv_pv_ao_r, p_la_pv_ao_r,
                p_ao_pt_ao_r, p_pa_pt_ao_r, p_rv_vt_ao_r, p_ra_vt_ao_r, p_lv_vt_ao_r, p_la_vt_ao_r, p_ao_vt_ao_r, p_pa_vt_ao_r]);

add_to_graphs_blue([p_rv_pt_ao_ym, p_ra_pt_ao_ym, p_lv_pt_ao_ym, p_la_pt_ao_ym, p_rv_pv_ao_ym, p_ra_pv_ao_ym, p_lv_pv_ao_ym, p_la_pv_ao_ym,
                p_ao_pt_ao_ym, p_pa_pt_ao_ym, p_rv_vt_ao_ym, p_ra_vt_ao_ym, p_lv_vt_ao_ym, p_la_vt_ao_ym, p_ao_vt_ao_ym, p_pa_vt_ao_ym]);

add_to_graphs_blue([p_rv_pt_pa_r, p_ra_pt_pa_r, p_lv_pt_pa_r, p_la_pt_pa_r, p_rv_pv_pa_r, p_ra_pv_pa_r, p_lv_pv_pa_r, p_la_pv_pa_r,
                p_ao_pt_pa_r, p_pa_pt_pa_r, p_rv_vt_pa_r, p_ra_vt_pa_r, p_lv_vt_pa_r, p_la_vt_pa_r, p_ao_vt_pa_r, p_pa_vt_pa_r]);

add_to_graphs_blue([p_rv_pt_pa_ym, p_ra_pt_pa_ym, p_lv_pt_pa_ym, p_la_pt_pa_ym, p_rv_pv_pa_ym, p_ra_pv_pa_ym, p_lv_pv_pa_ym, p_la_pv_pa_ym,
                p_ao_pt_pa_ym, p_pa_pt_pa_ym, p_rv_vt_pa_ym, p_ra_vt_pa_ym, p_lv_vt_pa_ym, p_la_vt_pa_ym, p_ao_vt_pa_ym, p_pa_vt_pa_ym]);

add_to_graphs_blue([p_rv_pt_la_v0, p_ra_pt_la_v0, p_lv_pt_la_v0, p_la_pt_la_v0, p_rv_pv_la_v0, p_ra_pv_la_v0, p_lv_pv_la_v0, p_la_pv_la_v0,
                p_ao_pt_la_v0, p_pa_pt_la_v0, p_rv_vt_la_v0, p_ra_vt_la_v0, p_lv_vt_la_v0, p_la_vt_la_v0, p_ao_vt_la_v0, p_pa_vt_la_v0]);

add_to_graphs_blue([p_rv_pt_ra_v0_ba, p_ra_pt_ra_v0_ba, p_lv_pt_ra_v0_ba, p_la_pt_ra_v0_ba, p_rv_pv_ra_v0_ba, p_ra_pv_ra_v0_ba, p_lv_pv_ra_v0_ba, p_la_pv_ra_v0_ba,
                p_ao_pt_ra_v0_ba, p_pa_pt_ra_v0_ba, p_rv_vt_ra_v0_ba, p_ra_vt_ra_v0_ba, p_lv_vt_ra_v0_ba, p_la_vt_ra_v0_ba, p_ao_vt_ra_v0_ba, p_pa_vt_ra_v0_ba]);

add_to_graphs_blue([p_rv_pt_lv_emax, p_ra_pt_lv_emax, p_lv_pt_lv_emax, p_la_pt_lv_emax, p_rv_pv_lv_emax, p_ra_pv_lv_emax, p_lv_pv_lv_emax, p_la_pv_lv_emax,
                p_ao_pt_lv_emax, p_pa_pt_lv_emax, p_rv_vt_lv_emax, p_ra_vt_lv_emax, p_lv_vt_lv_emax, p_la_vt_lv_emax, p_ao_vt_lv_emax, p_pa_vt_lv_emax]);

add_to_graphs_blue([p_rv_pt_rv_emax, p_ra_pt_rv_emax, p_lv_pt_rv_emax, p_la_pt_rv_emax, p_rv_pv_rv_emax, p_ra_pv_rv_emax, p_lv_pv_rv_emax, p_la_pv_rv_emax,
                p_ao_pt_rv_emax, p_pa_pt_rv_emax, p_rv_vt_rv_emax, p_ra_vt_rv_emax, p_lv_vt_rv_emax, p_la_vt_rv_emax, p_ao_vt_rv_emax, p_pa_vt_rv_emax]);

add_to_graphs_blue([p_rv_pt_lv_v0, p_ra_pt_lv_v0, p_lv_pt_lv_v0, p_la_pt_lv_v0, p_rv_pv_lv_v0, p_ra_pv_lv_v0, p_lv_pv_lv_v0, p_la_pv_lv_v0,
                p_ao_pt_lv_v0, p_pa_pt_lv_v0, p_rv_vt_lv_v0, p_ra_vt_lv_v0, p_lv_vt_lv_v0, p_la_vt_lv_v0, p_ao_vt_lv_v0, p_pa_vt_lv_v0]);

add_to_graphs_blue([p_rv_pt_ra_v0_bc, p_ra_pt_ra_v0_bc, p_lv_pt_ra_v0_bc, p_la_pt_ra_v0_bc, p_rv_pv_ra_v0_bc, p_ra_pv_ra_v0_bc, p_lv_pv_ra_v0_bc, p_la_pv_ra_v0_bc,
                p_ao_pt_ra_v0_bc, p_pa_pt_ra_v0_bc, p_rv_vt_ra_v0_bc, p_ra_vt_ra_v0_bc, p_lv_vt_ra_v0_bc, p_la_vt_ra_v0_bc, p_ao_vt_ra_v0_bc, p_pa_vt_ra_v0_bc]);

add_to_graphs_blue([p_rv_pt_vc_r, p_ra_pt_vc_r, p_lv_pt_vc_r, p_la_pt_vc_r, p_rv_pv_vc_r, p_ra_pv_vc_r, p_lv_pv_vc_r, p_la_pv_vc_r,
                p_ao_pt_vc_r, p_pa_pt_vc_r, p_rv_vt_vc_r, p_ra_vt_vc_r, p_lv_vt_vc_r, p_la_vt_vc_r, p_ao_vt_vc_r, p_pa_vt_vc_r]);
                
add_to_graphs_blue([p_rv_pt_vc_ym, p_ra_pt_vc_ym, p_lv_pt_vc_ym, p_la_pt_vc_ym, p_rv_pv_vc_ym, p_ra_pv_vc_ym, p_lv_pv_vc_ym, p_la_pv_vc_ym,
                p_ao_pt_vc_ym, p_pa_pt_vc_ym, p_rv_vt_vc_ym, p_ra_vt_vc_ym, p_lv_vt_vc_ym, p_la_vt_vc_ym, p_ao_vt_vc_ym, p_pa_vt_vc_ym]);



#########################
# ADD TO GRAPH FUNCTION #
#########################

function add_to_graphs_red(graph_list)
    plot!(graph_list[1], (sol.t.-19.0), sol[circ_sys.RV.p], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[2], (sol.t.-19.0), sol[circ_sys.RA.p], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[3], (sol.t.-19.0), sol[circ_sys.LV.p], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[4], (sol.t.-19.0), sol[circ_sys.LA.p], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[5], sol[circ_sys.RV.V], sol[circ_sys.RV.p], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[6], sol[circ_sys.RA.V], sol[circ_sys.RA.p], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[7], sol[circ_sys.LV.V], sol[circ_sys.LV.p], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[8], sol[circ_sys.LA.V], sol[circ_sys.LA.p], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[9], (sol.t.-19.0), sol[circ_sys.SAS.C.p], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[10], (sol.t.-19.0), sol[circ_sys.PAS.C.p], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[11], (sol.t.-19.0), sol[circ_sys.RV.V], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[12], (sol.t.-19.0), sol[circ_sys.RA.V], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[13], (sol.t.-19.0), sol[circ_sys.LV.V], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[14], (sol.t.-19.0), sol[circ_sys.LA.V], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[15], (sol.t.-19.0), sol[circ_sys.SAS.C.V], linewidth=2, linestyle=:dash, linecolor=:red)
    plot!(graph_list[16], (sol.t.-19.0), sol[circ_sys.PAS.C.V], linewidth=2, linestyle=:dash, linecolor=:red)
end


###################################
# DECREASE IN AORTIC SINUS RADIUS #
###################################

# Change necessary parameters
@named SAS = CRL(C=Csas*0.125, R=Rsas*16, L=Lsas*4);

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs
add_to_graphs_red([p_rv_pt_ao_r, p_ra_pt_ao_r, p_lv_pt_ao_r, p_la_pt_ao_r, p_rv_pv_ao_r, p_ra_pv_ao_r, p_lv_pv_ao_r, p_la_pv_ao_r,
                p_ao_pt_ao_r, p_pa_pt_ao_r, p_rv_vt_ao_r, p_ra_vt_ao_r, p_lv_vt_ao_r, p_la_vt_ao_r, p_ao_vt_ao_r, p_pa_vt_ao_r]);

# Revert to default case
@named SAS = CRL(C=Csas, R=Rsas, L=Lsas);

############################################
# DECREASE IN AORTIC SINUS YOUNG'S MODULUS #
############################################

# Change necessary parameters
@named SAS = CRL(C=Csas*3, R=Rsas, L=Lsas);

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs
add_to_graphs_red([p_rv_pt_ao_ym, p_ra_pt_ao_ym, p_lv_pt_ao_ym, p_la_pt_ao_ym, p_rv_pv_ao_ym, p_ra_pv_ao_ym, p_lv_pv_ao_ym, p_la_pv_ao_ym,
                p_ao_pt_ao_ym, p_pa_pt_ao_ym, p_rv_vt_ao_ym, p_ra_vt_ao_ym, p_lv_vt_ao_ym, p_la_vt_ao_ym, p_ao_vt_ao_ym, p_pa_vt_ao_ym]);

# Revert to default case
@named SAS = CRL(C=Csas, R=Rsas, L=Lsas);

######################################
# DECREASE IN PULMONARY SINUS RADIUS #
######################################

# Change necessary parameters
@named PAS = CRL(C=Cpas*0.204, R=Rpas*8.352, L=Lpas*2.89);

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs
add_to_graphs_red([p_rv_pt_pa_r, p_ra_pt_pa_r, p_lv_pt_pa_r, p_la_pt_pa_r, p_rv_pv_pa_r, p_ra_pv_pa_r, p_lv_pv_pa_r, p_la_pv_pa_r,
                p_ao_pt_pa_r, p_pa_pt_pa_r, p_rv_vt_pa_r, p_ra_vt_pa_r, p_lv_vt_pa_r, p_la_vt_pa_r, p_ao_vt_pa_r, p_pa_vt_pa_r]);

# Revert to default
@named PAS = CRL(C=Cpas, R=Rpas, L=Lpas);

#############################################
# DECREASED PULMONARY SINUS YOUNG'S MODULUS #
#############################################

# Change necessary parameters
@named PAS = CRL(C=Cpas*3, R=Rpas, L=Lpas);

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs
add_to_graphs_red([p_rv_pt_pa_ym, p_ra_pt_pa_ym, p_lv_pt_pa_ym, p_la_pt_pa_ym, p_rv_pv_pa_ym, p_ra_pv_pa_ym, p_lv_pv_pa_ym, p_la_pv_pa_ym,
                p_ao_pt_pa_ym, p_pa_pt_pa_ym, p_rv_vt_pa_ym, p_ra_vt_pa_ym, p_lv_vt_pa_ym, p_la_vt_pa_ym, p_ao_vt_pa_ym, p_pa_vt_pa_ym]);

# Revert to default
@named PAS = CRL(C=Cpas, R=Rpas, L=Lpas);


################################
# DECREASED LEFT ATRIUM VOLUME #
################################

# Change necessary parameters
@named LA = ShiChamber(V₀=v0_la*0.75, p₀=p0_la, Eₘᵢₙ=Emin_la, Eₘₐₓ=Emax_la, τ=τ, τₑₛ=τpww_la / 2, τₑₚ=τpww_la, Eshift=τpwb_la)

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs
add_to_graphs_red([p_rv_pt_la_v0, p_ra_pt_la_v0, p_lv_pt_la_v0, p_la_pt_la_v0, p_rv_pv_la_v0, p_ra_pv_la_v0, p_lv_pv_la_v0, p_la_pv_la_v0,
                p_ao_pt_la_v0, p_pa_pt_la_v0, p_rv_vt_la_v0, p_ra_vt_la_v0, p_lv_vt_la_v0, p_la_vt_la_v0, p_ao_vt_la_v0, p_pa_vt_la_v0]);

# Revert to default
@named LA = ShiChamber(V₀=v0_la, p₀=p0_la, Eₘᵢₙ=Emin_la, Eₘₐₓ=Emax_la, τ=τ, τₑₛ=τpww_la / 2, τₑₚ=τpww_la, Eshift=τpwb_la)

###########################################
# DECREASED LEFT ATRIUM VOLUME (BIATRIAL) #
###########################################

# Change necessary parameters
@named RA = ShiAtrium(V₀=v0_ra*0.75, p₀=1, Eₘᵢₙ=Emin_ra, Eₘₐₓ=Emax_ra, τ=τ, τpwb=τpwb_ra, τpww=τpww_ra);

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs
add_to_graphs_red([p_rv_pt_ra_v0_ba, p_ra_pt_ra_v0_ba, p_lv_pt_ra_v0_ba, p_la_pt_ra_v0_ba, p_rv_pv_ra_v0_ba, p_ra_pv_ra_v0_ba, p_lv_pv_ra_v0_ba, p_la_pv_ra_v0_ba,
                p_ao_pt_ra_v0_ba, p_pa_pt_ra_v0_ba, p_rv_vt_ra_v0_ba, p_ra_vt_ra_v0_ba, p_lv_vt_ra_v0_ba, p_la_vt_ra_v0_ba, p_ao_vt_ra_v0_ba, p_pa_vt_ra_v0_ba]);

# Revert to default
@named RA = ShiAtrium(V₀=v0_ra, p₀=1, Eₘᵢₙ=Emin_ra, Eₘₐₓ=Emax_ra, τ=τ, τpwb=τpwb_ra, τpww=τpww_ra);

######################################
# INCREASED LEFT VENTRICLE ELASTANCE #
######################################

# cHANGE NECESSARY PARAMETERS
@named LV = ShiChamber(V₀=v0_lv, p₀=p0_lv, Eₘᵢₙ=Emin_lv, Eₘₐₓ=Emax_lv*1.75, τ=τ, τₑₛ=τes_lv, τₑₚ=τed_lv, Eshift=0.0)

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to plots
add_to_graphs_red([p_rv_pt_lv_emax, p_ra_pt_lv_emax, p_lv_pt_lv_emax, p_la_pt_lv_emax, p_rv_pv_lv_emax, p_ra_pv_lv_emax, p_lv_pv_lv_emax, p_la_pv_lv_emax,
                p_ao_pt_lv_emax, p_pa_pt_lv_emax, p_rv_vt_lv_emax, p_ra_vt_lv_emax, p_lv_vt_lv_emax, p_la_vt_lv_emax, p_ao_vt_lv_emax, p_pa_vt_lv_emax]);

#Revert to default
@named LV = ShiChamber(V₀=v0_lv, p₀=p0_lv, Eₘᵢₙ=Emin_lv, Eₘₐₓ=Emax_lv, τ=τ, τₑₛ=τes_lv, τₑₚ=τed_lv, Eshift=0.0)

#######################################
# INCREASED RIGHT VENTRICLE ELASTANCE #
#######################################

# Change necessary parameters
@named RV = ShiChamber(V₀=v0_rv, p₀=p0_rv, Eₘᵢₙ=Emin_rv, Eₘₐₓ=Emax_rv*1.1, τ=τ, τₑₛ=τes_rv, τₑₚ=τed_rv, Eshift=0.0)

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs 
add_to_graphs_red([p_rv_pt_rv_emax, p_ra_pt_rv_emax, p_lv_pt_rv_emax, p_la_pt_rv_emax, p_rv_pv_rv_emax, p_ra_pv_rv_emax, p_lv_pv_rv_emax, p_la_pv_rv_emax,
                p_ao_pt_rv_emax, p_pa_pt_rv_emax, p_rv_vt_rv_emax, p_ra_vt_rv_emax, p_lv_vt_rv_emax, p_la_vt_rv_emax, p_ao_vt_rv_emax, p_pa_vt_rv_emax]);

# Revert to default
@named RV = ShiChamber(V₀=v0_rv, p₀=p0_rv, Eₘᵢₙ=Emin_rv, Eₘₐₓ=Emax_rv, τ=τ, τₑₛ=τes_rv, τₑₚ=τed_rv, Eshift=0.0)

###################################
# INCREASED LEFT VENTRICLE VOLUME #
###################################

# Change necessary parameters
@named LV = ShiChamber(V₀=v0_lv*1.5, p₀=p0_lv, Eₘᵢₙ=Emin_lv, Eₘₐₓ=Emax_lv, τ=τ, τₑₛ=τes_lv, τₑₚ=τed_lv, Eshift=0.0)

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs 
add_to_graphs_red([p_rv_pt_lv_v0, p_ra_pt_lv_v0, p_lv_pt_lv_v0, p_la_pt_lv_v0, p_rv_pv_lv_v0, p_ra_pv_lv_v0, p_lv_pv_lv_v0, p_la_pv_lv_v0,
                p_ao_pt_lv_v0, p_pa_pt_lv_v0, p_rv_vt_lv_v0, p_ra_vt_lv_v0, p_lv_vt_lv_v0, p_la_vt_lv_v0, p_ao_vt_lv_v0, p_pa_vt_lv_v0]);

# Revert to default
@named LV = ShiChamber(V₀=v0_lv, p₀=p0_lv, Eₘᵢₙ=Emin_lv, Eₘₐₓ=Emax_lv, τ=τ, τₑₛ=τes_lv, τₑₚ=τed_lv, Eshift=0.0)

###########################################
# DECREASED RIGHT ATRIUM VOLUME (BICAVAL) #
###########################################

# Change necessary parameters
@named RA = ShiAtrium(V₀=v0_ra*0.5, p₀=1, Eₘᵢₙ=Emin_ra, Eₘₐₓ=Emax_ra, τ=τ, τpwb=τpwb_ra, τpww=τpww_ra)

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs 
add_to_graphs_red([p_rv_pt_ra_v0_bc, p_ra_pt_ra_v0_bc, p_lv_pt_ra_v0_bc, p_la_pt_ra_v0_bc, p_rv_pv_ra_v0_bc, p_ra_pv_ra_v0_bc, p_lv_pv_ra_v0_bc, p_la_pv_ra_v0_bc,
                p_ao_pt_ra_v0_bc, p_pa_pt_ra_v0_bc, p_rv_vt_ra_v0_bc, p_ra_vt_ra_v0_bc, p_lv_vt_ra_v0_bc, p_la_vt_ra_v0_bc, p_ao_vt_ra_v0_bc, p_pa_vt_ra_v0_bc]);

# Revert to default
@named RA = ShiAtrium(V₀=v0_ra, p₀=1, Eₘᵢₙ=Emin_ra, Eₘₐₓ=Emax_ra, τ=τ, τpwb=τpwb_ra, τpww=τpww_ra)

##############################
# DECREASED VENA CAVA RADIUS #
##############################

# Change necessary parameters
@named SVN = CR(R=(0.075*0.995)+(0.075*0.005*1.916), C=(20.5*0.95)+(20.5*0.05*0.614));

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs
add_to_graphs_red([p_rv_pt_vc_r, p_ra_pt_vc_r, p_lv_pt_vc_r, p_la_pt_vc_r, p_rv_pv_vc_r, p_ra_pv_vc_r, p_lv_pv_vc_r, p_la_pv_vc_r,
                p_ao_pt_vc_r, p_pa_pt_vc_r, p_rv_vt_vc_r, p_ra_vt_vc_r, p_lv_vt_vc_r, p_la_vt_vc_r, p_ao_vt_vc_r, p_pa_vt_vc_r]);

# Revert to default
@named SVN = CR(R=Rsvn, C=Csvn);


#######################################
# DECREASED VENA CAVA YOUNG'S MODULUS #
#######################################

# Change necessary parameters
@named SVN = CR(R=Rsvn, C=(20.5*0.95)+(20.5*0.05*3));

# Create ODE system
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# Solve system of ODEs
prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20)

# Add to graphs 
add_to_graphs_red([p_rv_pt_vc_ym, p_ra_pt_vc_ym, p_lv_pt_vc_ym, p_la_pt_vc_ym, p_rv_pv_vc_ym, p_ra_pv_vc_ym, p_lv_pv_vc_ym, p_la_pv_vc_ym,
                p_ao_pt_vc_ym, p_pa_pt_vc_ym, p_rv_vt_vc_ym, p_ra_vt_vc_ym, p_lv_vt_vc_ym, p_la_vt_vc_ym, p_ao_vt_vc_ym, p_pa_vt_vc_ym]);

# Revert to default
@named SVN = CR(R=Rsvn, C=Csvn);





#############################
# MAKING AND SAVING FIGURES #
#############################

# Pressure in Left Ventricle
fig = plot(p_lv_pt_ao_r, p_lv_pt_ao_ym, p_lv_pt_pa_r, 
        p_lv_pt_pa_ym, p_lv_pt_la_v0, p_lv_pt_ra_v0_ba, 
        p_lv_pt_lv_emax, p_lv_pt_rv_emax, p_lv_pt_lv_v0,
        p_lv_pt_ra_v0_bc, p_lv_pt_vc_r, p_lv_pt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/lv_pt.pdf")

# Pressure in Right Ventricle
fig = plot(p_rv_pt_ao_r, p_rv_pt_ao_ym, p_rv_pt_pa_r, 
        p_rv_pt_pa_ym, p_rv_pt_la_v0, p_rv_pt_ra_v0_ba, 
        p_rv_pt_lv_emax, p_rv_pt_rv_emax, p_rv_pt_lv_v0,
        p_rv_pt_ra_v0_bc, p_rv_pt_vc_r, p_rv_pt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/rv_pt.pdf")

# Pressure in Left Atrium
fig = plot(p_la_pt_ao_r, p_la_pt_ao_ym, p_la_pt_pa_r, 
        p_la_pt_pa_ym, p_la_pt_la_v0, p_la_pt_ra_v0_ba, 
        p_la_pt_lv_emax, p_la_pt_rv_emax, p_la_pt_lv_v0,
        p_la_pt_ra_v0_bc, p_la_pt_vc_r, p_la_pt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/la_pt.pdf")

# Pressure in right Atrium
fig = plot(p_ra_pt_ao_r, p_ra_pt_ao_ym, p_ra_pt_pa_r, 
        p_ra_pt_pa_ym, p_ra_pt_la_v0, p_ra_pt_ra_v0_ba, 
        p_ra_pt_lv_emax, p_ra_pt_rv_emax, p_ra_pt_lv_v0,
        p_ra_pt_ra_v0_bc, p_ra_pt_vc_r, p_ra_pt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/ra_pt.pdf")

# Left Ventricle PV loop
fig = plot(p_lv_pv_ao_r, p_lv_pv_ao_ym, p_lv_pv_pa_r, 
        p_lv_pv_pa_ym, p_lv_pv_la_v0, p_lv_pv_ra_v0_ba, 
        p_lv_pv_lv_emax, p_lv_pv_rv_emax, p_lv_pv_lv_v0,
        p_lv_pv_ra_v0_bc, p_lv_pv_vc_r, p_lv_pv_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/lv_pv.pdf")

# Right Ventricle PV loop
fig = plot(p_rv_pv_ao_r, p_rv_pv_ao_ym, p_rv_pv_pa_r, 
        p_rv_pv_pa_ym, p_rv_pv_la_v0, p_rv_pv_ra_v0_ba, 
        p_rv_pv_lv_emax, p_rv_pv_rv_emax, p_rv_pv_lv_v0,
        p_rv_pv_ra_v0_bc, p_rv_pv_vc_r, p_rv_pv_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/rv_pv.pdf")

# Left Atrium PV loop
fig = plot(p_la_pv_ao_r, p_la_pv_ao_ym, p_la_pv_pa_r, 
        p_la_pv_pa_ym, p_la_pv_la_v0, p_la_pv_ra_v0_ba, 
        p_la_pv_lv_emax, p_la_pv_rv_emax, p_la_pv_lv_v0,
        p_la_pv_ra_v0_ba, p_la_pv_vc_r, p_la_pv_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/la_pv.pdf")

# Right Atrium PV loop
fig = plot(p_ra_pv_ao_r, p_ra_pv_ao_ym, p_ra_pv_pa_r, 
        p_ra_pv_pa_ym, p_ra_pv_la_v0, p_ra_pv_ra_v0_ba, 
        p_ra_pv_lv_emax, p_ra_pv_rv_emax, p_ra_pv_lv_v0,
        p_ra_pv_ra_v0_bc, p_ra_pv_vc_r, p_ra_pv_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/ra_pv.pdf")

# Pressure in Aortic sinus
fig = plot(p_ao_pt_ao_r, p_ao_pt_ao_ym, p_ao_pt_pa_r, 
        p_ao_pt_pa_ym, p_ao_pt_la_v0, p_ao_pt_ra_v0_ba, 
        p_ao_pt_lv_emax, p_ao_pt_rv_emax, p_ao_pt_lv_v0,
        p_ao_pt_ra_v0_bc, p_ao_pt_vc_r, p_ao_pt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/ao_pt.pdf")

# Pressure in Pulmonary Sinus
fig = plot(p_pa_pt_ao_r, p_ao_pt_ao_ym, p_pa_pt_pa_r, 
        p_pa_pt_pa_ym, p_pa_pt_la_v0, p_pa_pt_ra_v0_ba, 
        p_pa_pt_lv_emax, p_pa_pt_rv_emax, p_pa_pt_lv_v0,
        p_pa_pt_ra_v0_bc, p_pa_pt_vc_r, p_pa_pt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/pa_pt.pdf")

# Volume in Left Ventricle
fig = plot(p_lv_vt_ao_r, p_lv_vt_ao_ym, p_lv_vt_pa_r, 
        p_lv_vt_pa_ym, p_lv_vt_la_v0, p_lv_vt_ra_v0_ba, 
        p_lv_vt_lv_emax, p_lv_vt_rv_emax, p_lv_vt_lv_v0,
        p_lv_vt_ra_v0_bc, p_lv_vt_vc_r, p_lv_vt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/lv_vt.pdf")

# Volume in Right Ventricle
fig = plot(p_rv_vt_ao_r, p_rv_vt_ao_ym, p_rv_vt_pa_r, 
        p_rv_vt_pa_ym, p_rv_vt_la_v0, p_rv_vt_ra_v0_ba, 
        p_rv_vt_lv_emax, p_rv_vt_rv_emax, p_rv_vt_lv_v0,
        p_rv_vt_ra_v0_bc, p_rv_vt_vc_r, p_rv_vt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/rv_vt.pdf")

# Volume in Left Atrium
fig = plot(p_la_vt_ao_r, p_la_vt_ao_ym, p_la_vt_pa_r, 
        p_la_vt_pa_ym, p_la_vt_la_v0, p_la_vt_ra_v0_ba, 
        p_la_vt_lv_emax, p_la_vt_rv_emax, p_la_vt_lv_v0,
        p_la_vt_ra_v0_bc, p_la_vt_vc_r, p_la_vt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/la_vt.pdf")

# Volume in Right Atrium
fig = plot(p_ra_vt_ao_r, p_ra_vt_ao_ym, p_ra_vt_pa_r, 
        p_ra_vt_pa_ym, p_ra_vt_la_v0, p_ra_vt_ra_v0_ba, 
        p_ra_vt_lv_emax, p_ra_vt_rv_emax, p_ra_vt_lv_v0,
        p_ra_vt_ra_v0_bc, p_ra_vt_vc_r, p_ra_vt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/a_vt.pdf")

# Volume in Aortic Sinus
fig = plot(p_ao_vt_ao_r, p_ao_vt_ao_ym, p_ao_vt_pa_r, 
        p_ao_vt_pa_ym, p_ao_vt_la_v0, p_ao_vt_ra_v0_ba, 
        p_ao_vt_lv_emax, p_ao_vt_rv_emax, p_ao_vt_lv_v0,
        p_ao_vt_ra_v0_bc, p_ao_vt_vc_r, p_ao_vt_vc_ym, 
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/ao_vt.pdf")

# Volume in Pulmonary Sinus
fig = plot(p_pa_vt_ao_r, p_pa_vt_ao_ym, p_pa_vt_pa_r, 
        p_pa_vt_pa_ym, p_pa_vt_la_v0, p_pa_vt_ra_v0_ba, 
        p_pa_vt_lv_emax, p_pa_vt_rv_emax, p_pa_vt_lv_v0,
        p_pa_vt_ra_v0_bc, p_pa_vt_vc_r, p_pa_vt_vc_ym,
        layout=(4,3), margin=10Plots.mm)
plot!(size=(1200,1200))
savefig(fig, "plots/pa_vt.pdf")