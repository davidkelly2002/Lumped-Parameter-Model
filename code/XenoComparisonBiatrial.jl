using CirculatorySystemModels
using ModelingToolkit
using OrdinaryDiffEq
using Plots

include("ShiParam.jl") #Reference parameters
include("BiatrialParam.jl")
@independent_variables t

###############################
# MAKE BLANK GRAPHS TO ADD TO #
###############################

p_lv_pt = plot(xlabel="t (s)", ylabel="Pressure (mmHg)",title = "(a) Left Ventricle", legend=false)
p_rv_pt = plot(xlabel="t (s)", ylabel="Pressure (mmHg)",title = "(b) Right Ventricle", legend=false)
p_la_pt = plot(xlabel="t (s)", ylabel="Pressure (mmHg)",title = "(c) Left Atrium", legend=false)
p_ra_pt = plot(xlabel="t (s)", ylabel="Pressure (mmHg)",title = "(d) Right Atrium", legend=false)
p_lv_pv = plot(xlabel="Volume (ml)", ylabel="Pressure (mmHg)",title = "(e) Left Ventricle", legend=false)
p_rv_pv = plot(xlabel="Volume (ml)", ylabel="Pressure (mmHg)",title = "(f) Right Ventricle", legend=false)
p_la_pv = plot(xlabel="Volume (ml)", ylabel="Pressure (mmHg)",title = "(g) Left Atrium", legend=false)
p_ra_pv = plot(xlabel="Volume (ml)", ylabel="Pressure (mmHg)",title = "(h) Right Atrium", legend=false)
p_ao_pt = plot(xlabel="t (s)", ylabel="Pressure (mmHg)",title = "(i) Aorta", legend=false)
p_pa_pt = plot(xlabel="t (s)", ylabel="Pressure (mmHg)",title = "(j) Pulmonary Artery", legend=false)


##########################################
# BUILD MODEL OF REFERENCE HELATHY HUMAN #
##########################################

# DEFINE INDIVIDUAL COMPONENTS
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

# ADD TO PLOTS
plot!(p_rv_pt, (sol.t.-19.0), sol[circ_sys.RV.p], linewidth=2, linecolor=:blue)
plot!(p_ra_pt, (sol.t.-19.0), sol[circ_sys.RA.p], linewidth=2, linecolor=:blue)
plot!(p_lv_pt, (sol.t.-19.0), sol[circ_sys.LV.p], linewidth=2, linecolor=:blue)
plot!(p_la_pt, (sol.t.-19.0), sol[circ_sys.LA.p], linewidth=2, linecolor=:blue)
plot!(p_rv_pv, sol[circ_sys.RV.V], sol[circ_sys.RV.p], linewidth=2, linecolor=:blue)
plot!(p_ra_pv, sol[circ_sys.RA.V], sol[circ_sys.RA.p], linewidth=2, linecolor=:blue)
plot!(p_lv_pv, sol[circ_sys.LV.V], sol[circ_sys.LV.p], linewidth=2, linecolor=:blue)
plot!(p_la_pv, sol[circ_sys.LA.V], sol[circ_sys.LA.p], linewidth=2, linecolor=:blue)
plot!(p_ao_pt, (sol.t.-19.0), sol[circ_sys.SAS.C.p], linewidth=2, linecolor=:blue)
plot!(p_pa_pt, (sol.t.-19.0), sol[circ_sys.PAS.C.p], linewidth=2, linecolor=:blue);


#############################################################
# BUILD MODEL HUMAN CIRCULATION WITH TRANSPLANTED PIG HEART #
#############################################################

# DEFINE INDIVIDUAL COMPONENTS
# Heart chambers
@named LV = ShiChamber(V₀=v0_lv_ba, p₀=p0_lv_ba, Eₘᵢₙ=Emin_lv_ba, Eₘₐₓ=Emax_lv_ba, τ=τ_ba, τₑₛ=τes_lv_ba, τₑₚ=τed_lv_ba, Eshift=0.0)
@named LA = ShiChamber(V₀=v0_la_ba, p₀=p0_la_ba, Eₘᵢₙ=Emin_la_ba, Eₘₐₓ=Emax_la_ba, τ=τ_ba, τₑₛ=τpww_la_ba / 2, τₑₚ=τpww_la_ba, Eshift=τpwb_la_ba)
@named RV = ShiChamber(V₀=v0_rv_ba, p₀=p0_rv_ba, Eₘᵢₙ=Emin_rv_ba, Eₘₐₓ=Emax_rv_ba, τ=τ_ba, τₑₛ=τes_rv_ba, τₑₚ=τed_rv_ba, Eshift=0.0)
@named RA = ShiAtrium(V₀=v0_ra_ba, p₀=1, Eₘᵢₙ=Emin_ra_ba, Eₘₐₓ=Emax_ra_ba, τ=τ_ba, τpwb=τpwb_ra_ba, τpww=τpww_ra_ba)

# Valves
@named AV = OrificeValve(CQ=CQ_AV_ba)
@named MV = OrificeValve(CQ=CQ_MV_ba)
@named TV = OrificeValve(CQ=CQ_TV_ba)
@named PV = OrificeValve(CQ=CQ_PV_ba)  

# Systemic circulation
@named SAS = CRL(C=Csas_ba, R=Rsas_ba, L=Lsas_ba)
@named SAT = CRL(C=Csat_ba, R=Rsat_ba, L=Lsat_ba)
@named SAR = Resistor(R=Rsar_ba)
@named SCP = Resistor(R=Rscp_ba)
@named SVN = CR(R=Rsvn, C=Csvn) 

# Pulmonary circulation
@named PAS = CRL(C=Cpas_ba, R=Rpas_ba, L=Lpas_ba)
@named PAT = CRL(C=Cpat_ba, R=Rpat_ba, L=Lpat_ba)
@named PAR = Resistor(R=Rpar_ba)
@named PCP = Resistor(R=Rpcp_ba)
@named PVN = CR(R=Rpvn_ba, C=Cpvn_ba)

# CONNECT COMPONENTS TO FORM CIRCUIT
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
];

# CREATE ODE SYSTEM
@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model,
[LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

## Setup ODE
# Initial Conditions for Shi Valve
u0 = [
        LV.V => LV_Vt0_ba
        RV.V => RV_Vt0_ba
        LA.V => LA_Vt0_ba
        RA.V => RA_Vt0_ba
        SAS.C.p => pt0sas_ba
        SAS.L.q => qt0sas_ba
        SAT.C.p => pt0sat_ba
        SAT.L.q => qt0sat_ba
        SVN.C.p => pt0svn_ba
        PAS.C.p => pt0pas_ba
        PAS.L.q => qt0pas_ba
        PAT.C.p => pt0pat_ba
        PAT.L.q => qt0pat_ba
        PVN.C.p => pt0pvn_ba
    ]

prob = ODEProblem(circ_sys, u0, (0.0, 20.0))
sol = solve(prob, RK4(), reltol=1e-9, abstol=1e-12, saveat=19:0.01:20);


# ADD TO PLOTS
plot!(p_rv_pt, (sol.t.-19.0), sol[circ_sys.RV.p], linewidth=2, linestyle=:dash, linecolor=:red)
plot!(p_ra_pt, (sol.t.-19.0), sol[circ_sys.RA.p], linewidth=2, linestyle=:dash, linecolor=:red)
plot!(p_lv_pt, (sol.t.-19.0), sol[circ_sys.LV.p], linewidth=2, linestyle=:dash, linecolor=:red)
plot!(p_la_pt, (sol.t.-19.0), sol[circ_sys.LA.p], linewidth=2, linestyle=:dash, linecolor=:red)
plot!(p_rv_pv, sol[circ_sys.RV.V], sol[circ_sys.RV.p], linewidth=2, linestyle=:dash, linecolor=:red)
plot!(p_ra_pv, sol[circ_sys.RA.V], sol[circ_sys.RA.p], linewidth=2, linestyle=:dash, linecolor=:red)
plot!(p_lv_pv, sol[circ_sys.LV.V], sol[circ_sys.LV.p], linewidth=2, linestyle=:dash, linecolor=:red)
plot!(p_la_pv, sol[circ_sys.LA.V], sol[circ_sys.LA.p], linewidth=2, linestyle=:dash, linecolor=:red)
plot!(p_ao_pt, (sol.t.-19.0), sol[circ_sys.SAS.C.p], linewidth=2, linestyle=:dash, linecolor=:red)
plot!(p_pa_pt, (sol.t.-19.0), sol[circ_sys.PAS.C.p], linewidth=2, linestyle=:dash, linecolor=:red)


###################
# DISPLAY RESULTS #
###################

legend = plot([0], showaxis = false, grid = false, label = "Reference healthy human", legend = :topleft, margin=5Plots.mm, 
            legendfontsize=16, c=:blue, lw=2)
plot!(legend, [0], showaxis = false, grid = false, label = "Human with transplanted pig heart", c=:red, ls=:dash, lw=2) 
fig = plot(p_lv_pt, 
            p_rv_pt, 
            p_la_pt, 
            p_ra_pt, 
            p_lv_pv, 
            p_rv_pv, 
            p_la_pv, 
            p_ra_pv, 
            p_ao_pt, 
            p_pa_pt,
            legend,
            layout=(6,2), 
            margin=10Plots.mm)
plot!(size=(900,1800))
savefig(fig, "plots/total_biatrial_results.pdf")