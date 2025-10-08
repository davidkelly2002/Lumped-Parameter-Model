# pv_loop.jl
using CirculatorySystemModels
using ModelingToolkit
using OrdinaryDiffEq
using Plots

# ----------------------------------
# Params (expects ShiParam.jl nearby)
# ----------------------------------
include(joinpath(@__DIR__, "ShiParam.jl"))

# ----------------
# Helper functions
# ----------------
# Safely fetch the first solution series that exists
tryget(sol, vars...) = begin
    for v in vars
        try
            y = sol[v]
            if !isempty(y); return y; end
        catch
        end
    end
    return nothing
end

# Chamber volume (handles possible nesting)
vol(sol, comp) = try
    sol[comp.V]
catch
    sol[comp.C.V]
end

# Chamber pressure (robust to simplification)
press(sol, comp; fallbacks=Tuple{}) = tryget(sol, comp.p, comp.out.p, fallbacks...)

# compute EDV/ESV/SV/EF from a single-cycle V(t), p(t)
function pv_stats(V::AbstractVector, p::AbstractVector)
    @assert length(V) == length(p) && !isempty(V)
    iED = argmax(V)              # end-diastole ~ max volume
    iES = argmin(V)              # end-systole  ~ min volume
    EDV = V[iED]; ESV = V[iES]
    SV  = EDV - ESV
    EF  = SV / EDV
    return (iED=iED, iES=iES, EDV=EDV, ESV=ESV, SV=SV, EF=EF)
end


# macOS helper: open file in Preview
reveal(path) = run(`open $(path)`)

# -------------------------
# Build the Shi closed loop
# -------------------------
@parameters t
@independent_variables t  # (for MTK <= v9 compatibility)

# Chambers
@named LV = ShiChamber(V₀=v0_lv, p₀=p0_lv, Eₘᵢₙ=Emin_lv, Eₘₐₓ=Emax_lv, τ=τ, τₑₛ=τes_lv, τₑₚ=τed_lv, Eshift=0.0)
@named LA = ShiChamber(V₀=v0_la, p₀=p0_la, Eₘᵢₙ=Emin_la, Eₘₐₓ=Emax_la, τ=τ, τₑₛ=τpww_la/2, τₑₚ=τpww_la, Eshift=τpwb_la)
@named RV = ShiChamber(V₀=v0_rv, p₀=p0_rv, Eₘᵢₙ=Emin_rv, Eₘₐₓ=Emax_rv, τ=τ, τₑₛ=τes_rv, τₑₚ=τed_rv, Eshift=0.0)
@named RA = ShiAtrium( V₀=v0_ra, p₀=1,    Eₘᵢₙ=Emin_ra, Eₘₐₓ=Emax_ra, τ=τ, τpwb=τpwb_ra, τpww=τpww_ra)

# Valves
@named AV = OrificeValve(CQ=CQ_AV)
@named MV = OrificeValve(CQ=CQ_MV)
@named TV = OrificeValve(CQ=CQ_TV)
@named PV = OrificeValve(CQ=CQ_PV)

# Vessels
@named SAS = CRL(C=Csas, R=Rsas, L=Lsas)
@named SAT = CRL(C=Csat, R=Rsat, L=Lsat)
@named SAR = Resistor(R=Rsar)
@named SCP = Resistor(R=Rscp)
@named SVN = CR(R=Rsvn, C=Csvn)

@named PAS = CRL(C=Cpas, R=Rpas, L=Lpas)
@named PAT = CRL(C=Cpat, R=Rpat, L=Lpat)
@named PAR = Resistor(R=Rpar)
@named PCP = Resistor(R=Rpcp)
@named PVN = CR(R=Rpvn, C=Cpvn)

# Connections
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

@named _circ_model = ODESystem(circ_eqs, t)
@named circ_model = compose(_circ_model, [LV, RV, LA, RA, AV, MV, PV, TV, SAS, SAT, SAR, SCP, SVN, PAS, PAT, PAR, PCP, PVN])
circ_sys = structural_simplify(circ_model)

# ------------------
# Initial conditions
# ------------------
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

# -----
# Solve
# -----
tspan = (0.0, 20.0)                 # simulate long enough to reach periodic steady state
savegrid = 0.0:0.002:20.0           # smooth PV loop
prob = ODEProblem(circ_sys, u0, tspan)
@time sol = solve(prob, Tsit5(); reltol=1e-9, abstol=1e-12, saveat=savegrid)

# ================================
# Combined PV loops (LV, RV, LA, RA)
# ================================

# (re)compute time window for the last full cardiac cycle
tt   = collect(sol.t)
tend = maximum(tt)
t1   = max(first(tt), tend - τ)
win  = (tt .>= t1) .& (tt .<= tend)

# robust pressures (fallback to upstream port if internal p was aliased)
p_lv = press(sol, LV; fallbacks=(AV.in.p,))
p_rv = press(sol, RV; fallbacks=(PV.in.p,))
p_la = press(sol, LA; fallbacks=(MV.in.p, LA.out.p))
p_ra = press(sol, RA; fallbacks=(TV.in.p, RA.out.p))

# volumes
V_lv = vol(sol, LV);   V_rv = vol(sol, RV)
V_la = vol(sol, LA);   V_ra = vol(sol, RA)

# windowed series (last cycle)
p_lv_c, V_lv_c = p_lv[win], V_lv[win]
p_rv_c, V_rv_c = p_rv[win], V_rv[win]
p_la_c, V_la_c = p_la[win], V_la[win]
p_ra_c, V_ra_c = p_ra[win], V_ra[win]

# EDV/ESV markers (max/min V in the window)
lv = pv_stats(V_lv_c, p_lv_c)
rv = pv_stats(V_rv_c, p_rv_c)
la = pv_stats(V_la_c, p_la_c)
ra = pv_stats(V_ra_c, p_ra_c)

# style (use your existing defaults; add margins if not already defined)
if !isdefined(@__MODULE__, :MARGINS)
    using Plots: mm
    MARGINS = (left_margin=8mm, right_margin=6mm, bottom_margin=8mm, top_margin=6mm)
end

# individual panels
pltLV = plot(V_lv_c, p_lv_c; xlabel="V_lv [ml]", ylabel="p_lv [mmHg]",
             title="Left Ventricle", legend=:topright, framestyle=:box, grid=:on, lw=2, MARGINS...)
scatter!(pltLV, [V_lv_c[lv.iED]], [p_lv_c[lv.iED]], label="EDV", ms=6)
scatter!(pltLV, [V_lv_c[lv.iES]], [p_lv_c[lv.iES]], label="ESV", ms=6)

pltRV = plot(V_rv_c, p_rv_c; xlabel="V_rv [ml]", ylabel="p_rv [mmHg]",
             title="Right Ventricle", legend=:topright, framestyle=:box, grid=:on, lw=2, MARGINS...)
scatter!(pltRV, [V_rv_c[rv.iED]], [p_rv_c[rv.iED]], label="EDV", ms=6)
scatter!(pltRV, [V_rv_c[rv.iES]], [p_rv_c[rv.iES]], label="ESV", ms=6)

pltLA = plot(V_la_c, p_la_c; xlabel="V_la [ml]", ylabel="p_la [mmHg]",
             title="Left Atrium", legend=:topright, framestyle=:box, grid=:on, lw=2, MARGINS...)
scatter!(pltLA, [V_la_c[la.iED]], [p_la_c[la.iED]], label="EDV", ms=6)
scatter!(pltLA, [V_la_c[la.iES]], [p_la_c[la.iES]], label="ESV", ms=6)
# Optional atrial axis tightening:
# ylims!(pltLA, (0, 25))

pltRA = plot(V_ra_c, p_ra_c; xlabel="V_ra [ml]", ylabel="p_ra [mmHg]",
             title="Right Atrium", legend=:topright, framestyle=:box, grid=:on, lw=2, MARGINS...)
scatter!(pltRA, [V_ra_c[ra.iED]], [p_ra_c[ra.iED]], label="EDV", ms=6)
scatter!(pltRA, [V_ra_c[ra.iES]], [p_ra_c[ra.iES]], label="ESV", ms=6)
# ylims!(pltRA, (0, 25))

# combine to a single PDF
fig_all = plot(pltLV, pltRV, pltLA, pltRA, layout=(2,2), size=(1200, 900))
savefig(fig_all, "plots/pv_loops_all.pdf")
#run(`open pv_loops_all.pdf`)  # macOS Preview
println("Saved -> pv_loops_all.pdf")


