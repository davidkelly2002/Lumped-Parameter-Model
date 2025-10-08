using CirculatorySystemModels
using ModelingToolkit
using OrdinaryDiffEq
using Test
using CSV
using DataFrames
using Plots
gr()  # ensure GR backend

# Global defaults so every plot inherits these
default(
    dpi = 220,
    background_color = :white,
    foreground_color = :black,
    titlefontsize = 16,
    guidefontsize = 14,   # axis labels
    tickfontsize  = 12,
    legendfontsize= 12,
)

# Margin units
using Plots: mm
MARGINS = (left_margin=8mm, right_margin=6mm, bottom_margin=8mm, top_margin=6mm)

# Your existing common kws
common_kw = (legend=:topright, framestyle=:box, grid=:on, lw=2)


include("ShiParam.jl")

@independent_variables t


## Ventricles
@named LV = ShiChamber(V₀=v0_lv, p₀=p0_lv, Eₘᵢₙ=Emin_lv, Eₘₐₓ=Emax_lv, τ=τ, τₑₛ=τes_lv, τₑₚ=τed_lv, Eshift=0.0)
# The atrium can be defined either as a ShiChamber with changed timing parameters, or as defined in the paper
@named LA = ShiChamber(V₀=v0_la, p₀=p0_la, Eₘᵢₙ=Emin_la, Eₘₐₓ=Emax_la, τ=τ, τₑₛ=τpww_la / 2, τₑₚ=τpww_la, Eshift=τpwb_la)
@named RV = ShiChamber(V₀=v0_rv, p₀=p0_rv, Eₘᵢₙ=Emin_rv, Eₘₐₓ=Emax_rv, τ=τ, τₑₛ=τes_rv, τₑₚ=τed_rv, Eshift=0.0)
# The atrium can be defined either as a ShiChamber with changed timing parameters, or as defined in the paper
# @named RA = ShiChamber(V₀=v0_ra, p₀ = p0_ra, Eₘᵢₙ=Emin_ra, Eₘₐₓ=Emax_ra, τ=τ, τₑₛ=τpww_ra/2, τₑₚ =τpww_ra, Eshift=τpwb_ra)
@named RA = ShiAtrium(V₀=v0_ra, p₀=1, Eₘᵢₙ=Emin_ra, Eₘₐₓ=Emax_ra, τ=τ, τpwb=τpwb_ra, τpww=τpww_ra) #, Ev=Inf)


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
    # u0 = [LV_Vt0, RV_Vt0, LA_Vt0, RA_Vt0, pt0sas, qt0sas , pt0sat, qt0sat, pt0svn, pt0pas, qt0pas, pt0pat, qt0pat, pt0pvn, 0, 0, 0, 0,0, 0, 0, 0]
    # and for OrificeValve --- Commment this next line to use ShiValves
    # u0 = [LV_Vt0, RV_Vt0, LA_Vt0, RA_Vt0, pt0sas, qt0sas, pt0sat, qt0sat, pt0svn, pt0pas, qt0pas, pt0pat, qt0pat, pt0pvn]

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
    ##
    @time ShiSimpleSolV = solve(prob, Tsit5(), reltol=1e-9, abstol=1e-12, saveat=9:0.01:11)
    # ShiSimpleSolV = ShiSimpleSolV(19:0.01:20)


    ########################
#  Helpers (paste once)
########################

# time vector from the solution
tt = collect(ShiSimpleSolV.t)

# Return the first variable that actually exists in `sol`
tryget(sol, vars...) = begin
    for v in vars
        try
            y = sol[v]
            if !isempty(y)
                return y
            end
        catch
            # variable not present; try next
        end
    end
    return nothing
end

# Chamber volume (handles cases where V is nested in a compliance subcomponent)
vol(sol, comp) = try
    sol[comp.V]
catch
    sol[comp.C.V]
end

# Make valve flow positive in the physiological in→out direction
forward_q(sol, comp) = begin
    try
        return sol[comp.in.q]      # upstream pin (preferred)
    catch
        return .-sol[comp.out.q]   # fallback: negate downstream pin
    end
end

########################
#       PLOTTING       #
########################

# ---------- macOS opener ----------
reveal(path) = run(`open $(path)`)

# view window (change as you like)
const XWIN = (9.0, 11.0)

# common plot options
common_kw = (legend = :topright, framestyle = :box, grid = :on, lw = 2)

# =========================
# 1) PRESSURES (left/right)
# =========================
lv_p = tryget(ShiSimpleSolV, LV.p, LV.out.p, AV.in.p)
la_p = tryget(ShiSimpleSolV, LA.p, LA.out.p, MV.in.p)
ao_p = tryget(ShiSimpleSolV, SAS.C.p, AV.out.p, SAS.in.p, SAS.out.p, SAT.in.p)

rv_p = tryget(ShiSimpleSolV, RV.p, RV.out.p, PV.in.p)
ra_p = tryget(ShiSimpleSolV, RA.p, RA.out.p, TV.in.p)
pa_p = tryget(ShiSimpleSolV, PAS.C.p, PV.out.p, PAS.in.p, PAS.out.p, PAT.in.p)

pltPL = plot(title="Left heart & aorta (pressure)", xlabel="Time [s]", ylabel="Pressure [mmHg]";
             common_kw..., MARGINS...)
lv_p !== nothing && plot!(pltPL, tt, lv_p, label = "LV")
la_p !== nothing && plot!(pltPL, tt, la_p, label = "LA")
ao_p !== nothing && plot!(pltPL, tt, ao_p, label = "Aorta")
xlims!(pltPL, XWIN)

pltPR = plot(title="Right heart & PA (pressure)", xlabel="Time [s]", ylabel="Pressure [mmHg]";
             common_kw..., MARGINS...)
rv_p !== nothing && plot!(pltPR, tt, rv_p, label = "RV")
ra_p !== nothing && plot!(pltPR, tt, ra_p, label = "RA")
pa_p !== nothing && plot!(pltPR, tt, pa_p, label = "Pulmonary artery")
xlims!(pltPR, XWIN)

figP = plot(pltPL, pltPR, layout=(1,2), size=(1400,560))
#savefig(figP, "pressures_left_right.png")
#reveal("pressures_left_right.png")
#println("Saved -> pressures_left_right.png")

# =====================
# 2) FLOWS (Shi figure)
# =====================
# Q(mi), Q(ao), Q(ti), Q(pa)
q_mi = forward_q(ShiSimpleSolV, MV)   # mitral inflow

q_ao = try
    ShiSimpleSolV[SAS.L.q]            # aortic root (inductor) if present
catch
    forward_q(ShiSimpleSolV, AV)      # else valve flow
end

q_ti = forward_q(ShiSimpleSolV, TV)   # tricuspid inflow

q_pa = try
    ShiSimpleSolV[PAS.L.q]            # pulmonary root (inductor) if present
catch
    forward_q(ShiSimpleSolV, PV)      # else valve flow
end

pltFL = plot(title="Left heart flows", xlabel="t [s]", ylabel="Q [ml/s]"; common_kw..., MARGINS...)
plot!(pltFL, tt, q_mi, label = "Q(mi)", linestyle = :solid)
plot!(pltFL, tt, q_ao, label = "Q(ao)", linestyle = :dot)
xlims!(pltFL, XWIN)

pltFR = plot(title="Right heart flows", xlabel="t [s]", ylabel="Q [ml/s]"; common_kw..., MARGINS...)
plot!(pltFR, tt, q_ti, label = "Q(ti)", linestyle = :solid)
plot!(pltFR, tt, q_pa, label = "Q(pa)", linestyle = :dot)
xlims!(pltFR, XWIN)

figF = plot(pltFL, pltFR, layout = (1, 2), size = (1400, 560))
#savefig(figF, "flows_Q_mi_ao_ti_pa.png")
#reveal("flows_Q_mi_ao_ti_pa.png")
#println("Saved -> flows_Q_mi_ao_ti_pa.png")

# =========================
# 3) VOLUMES (left / right)
# =========================
lv_V = vol(ShiSimpleSolV, LV);  la_V = vol(ShiSimpleSolV, LA)
rv_V = vol(ShiSimpleSolV, RV);  ra_V = vol(ShiSimpleSolV, RA)

pltVL = plot(title="Left heart volumes", xlabel="t [s]", ylabel="V [ml]"; common_kw..., MARGINS...)
plot!(pltVL, tt, lv_V, label="V(lv)", linestyle=:solid)   # ← add LV
plot!(pltVL, tt, la_V, label="V(la)", linestyle=:dot)
xlims!(pltVL, XWIN)   # or xwin if that's what you use

pltVR = plot(title="Right heart volumes", xlabel="t [s]", ylabel="V [ml]"; common_kw..., MARGINS...)
plot!(pltVR, tt, rv_V, label="V(rv)", linestyle=:solid)   # ← add RV
plot!(pltVR, tt, ra_V, label="V(ra)", linestyle=:dot)
xlims!(pltVR, XWIN)

figV = plot(pltVL, pltVR, layout=(1,2), size=(1400,560))
#savefig(figV, "volumes_lv_la_rv_ra.png")
#reveal("volumes_lv_la_rv_ra.png")
#println("Saved -> volumes_lv_la_rv_ra.png")

# =========================
# 4) ELASTANCE (left/right)
# =========================
# Use Shi’s double-cosine elastance with your mapped timings.
# If you’re using your own Elastance function, just swap the calls below.

E_lv = CirculatorySystemModels.ShiElastance.(tt, Emin_lv, Emax_lv, τ,  τes_lv,         τed_lv,         0.0)
E_la = CirculatorySystemModels.ShiElastance.(tt, Emin_la, Emax_la, τ,  τpww_la/2,      τpww_la,        τpwb_la)
E_rv = CirculatorySystemModels.ShiElastance.(tt, Emin_rv, Emax_rv, τ,  τes_rv,         τed_rv,         0.0)
E_ra = CirculatorySystemModels.ShiElastance.(tt, Emin_ra, Emax_ra, τ,  τpww_ra/2,      τpww_ra,        τpwb_ra)

pltEL = plot(title="Left heart elastance",  xlabel="t [s]", ylabel="E [mmHg/ml]"; common_kw..., MARGINS...)
plot!(pltEL, tt, E_lv, label="E_lv", linestyle=:solid)
plot!(pltEL, tt, E_la, label="E_la", linestyle=:dot)
xlims!(pltEL, XWIN)   # or xwin if that’s what you defined

pltER = plot(title="Right heart elastance", xlabel="t [s]", ylabel="E [mmHg/ml]"; common_kw..., MARGINS...)
plot!(pltER, tt, E_rv, label="E_rv", linestyle=:solid)
plot!(pltER, tt, E_ra, label="E_ra", linestyle=:dot)
xlims!(pltER, XWIN)

figE = plot(pltEL, pltER, layout=(1,2), size=(1400,560))
#savefig(figE, "elastance_left_right.png")
#reveal("elastance_left_right.png")
#println("Saved -> elastance_left_right.png")


# ================
# ONE-PDF EXPORT
# ================
all_fig = plot(
    pltPL, pltPR,       # pressures (L/R)
    pltFL, pltFR,       # flows (L/R)
    pltVL, pltVR,       # volumes (L/R)
    pltEL, pltER;       # elastance (L/R)
    layout = (4, 2),
    size   = (1600, 2200)
)

savefig(all_fig, "plots/all_plots.pdf")
#reveal("all_plots.pdf")   # opens in Preview on macOS
println("Saved -> all_plots.pdf")