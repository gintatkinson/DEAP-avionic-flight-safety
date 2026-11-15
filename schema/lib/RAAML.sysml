standard library package RAAML {
  doc /* OMG RAAML v1.0 safety, reliability, 3-Ring, and RTA standard library. */

  private import ISQ::*;
  public import ThreeRing::DocTier;
  public import ThreeRing::TraceReq;
  public import ThreeRing::VerificationTest;
  public import ThreeRing::AssuranceRing;
  public import ThreeRing::AssuranceTier;
  public import ThreeRing::AuthorityRank;
  public import ThreeRing::ActionPartition;
  public import ThreeRing::LifecycleRole;
  public import ThreeRing::MissionTask;
  public import ThreeRing::EmergencyRule;
  public import ThreeRing::SignalContract;
  public import ThreeRing::CrossRingBoundary;
  public import ThreeRing::CodegenTarget;
  public import STPA::*;
  public import EMV2::*;
  public import FMEDA::*;
  public import FTA::*;
  public import RTA::*;

  enum def RingLevel { enum Ring1; enum Ring2; enum Ring3; }
  enum def TierLevel { enum Tier1; enum Tier2; enum Tier3; enum Tier4; enum Tier5; }
  enum def ActionKind { enum Ops; enum Control; enum Focus; enum Aux; }
  enum def ModeRole { enum Init; enum Nom; enum Deg; enum SafeHold; }
  enum def StpaGuideword { enum NotProvided; enum ProvidedUnsafe; enum WrongTimingOrOrder; enum DurationTooShortOrLong; }
  enum def ScenarioClass { enum Class1FeedbackOrController; enum Class2ExecutionOrPlant; }
  enum def Emv2DeviationClass { enum Omission; enum Commission; enum TimingDeviation; enum ValueDeviation; }
  enum def HyperedgeTopology { enum PointToPoint; enum Broadcast1ToN; enum WiredOrMTo1; }
  enum def FaultTreeGateKind { enum OrGate; enum AndGate; enum PriorityAndGate; enum VotingKOfN; }
  enum def DocTierKind { enum Tier1Gov; enum Tier2Arch; enum Tier3Model; enum Tier4Spec; enum Tier5Impl; }

  enum def ShardSubQualifier {
    enum ServiceOmission;
    enum SilentDrop;
    enum UncommandedActivation;
    enum Babbling;
    enum TimingEarly;
    enum TimingLate;
    enum RateHigh;
    enum RateLow;
    enum ValueHigh;
    enum ValueLow;
    enum ValueStuck;
    enum ValueCorrupt;
    enum ValueOutOfBounds;
    enum ValueSubtle;
  }

  part def SystemOfInterest;
  part def Subsystem;
  part def ControlledProcess;
  part def ExternalActor;
  action def OperationalActivity;
  requirement def MissionEssentialTask { subject sys : SystemOfInterest; }
  state def LifecycleStateMachine;
  verification def VerificationTestCase { subject sys : SystemOfInterest; }
  requirement def LifecycleAssuranceObjective { subject sys : SystemOfInterest; }

  package ThreeRing {
    doc /* 3-Ring containment, operational, signal, and traceability metadata. */
    private import ISQ::*;

    metadata def DocTier { attribute tier : DocTierKind; attribute docPath : Str; }
    metadata def TraceReq { attribute reqId : Str; attribute rationale : Str = ""; }
    metadata def VerificationTest { attribute testId : Str; attribute reqId : Str; attribute method : Str = "FormalAnalysis"; }
    metadata def AssuranceRing { attribute ring : RingLevel; }
    metadata def AssuranceTier { attribute tier : TierLevel; }
    metadata def AuthorityRank { attribute rho : Real64; attribute roleName : Str = ""; }
    metadata def ActionPartition { attribute kind : ActionKind; }
    metadata def LifecycleRole { attribute role : ModeRole; attribute terminalSafe : Bool = false; attribute requiresSupReset : Bool = false; }
    metadata def OperationalActivity { attribute oaId : Str; attribute phase : Str; attribute summary : Str = ""; }
    metadata def MissionTask { attribute metId : Str; attribute metricName : Str; attribute thresholdVal : Real64; attribute objectiveVal : Real64; attribute unitSym : Str; }
    metadata def EmergencyRule { attribute emgId : Str; attribute triggerCondition : Str; attribute targetMode : ModeRole; attribute maxReactionS : Duration_s; }
    metadata def SignalContract { attribute sigId : Str; attribute unitSym : Str; attribute minVal : Real64; attribute maxVal : Real64; attribute safeVal : Real64; attribute rateHz : Frequency_Hz; attribute maxLatencyS : Duration_s; }
    metadata def CrossRingBoundary { attribute srcRing : RingLevel; attribute dstRing : RingLevel; attribute crc32c : Bool = true; attribute missMax : Int64 = 3; attribute watchdogS : Duration_s = 0.050 [s]; }
    metadata def CodegenTarget { attribute crateName : Str; attribute tqlLevel : Str; attribute noStd : Bool = false; attribute isPassiveSubstrate : Bool = false; }
  }

  package STPA {
    doc /* MIT STPA top-down control-theoretic hazard metadata. */
    private import ISQ::*;

    metadata def Loss { attribute lossId : Str; attribute severity : Int64; attribute stakeholderRef : Str; }
    metadata def Hazard { attribute hazardId : Str; attribute lossRefs : Str; attribute envNegation : Str; }
    metadata def ControlAction { attribute caId : Str; attribute srcRank : Real64; attribute dstRank : Real64; attribute opsRef : Str; }
    metadata def UnsafeControlAction { attribute ucaId : Str; attribute caId : Str; attribute guideword : StpaGuideword; attribute stateContext : Str; attribute hazardRef : Str; }
    metadata def LossScenario { attribute lsId : Str; attribute ucaId : Str; attribute scenarioClass : ScenarioClass; attribute opsRef : Str; }
    metadata def SafetyConstraint { attribute scId : Str; attribute hazardRef : Str; attribute fttiS : Duration_s; attribute opsRef : Str; }
    metadata def ControllerConstraint { attribute cscId : Str; attribute ucaId : Str; attribute negatedGuard : Str; attribute opsRef : Str; }
  }

  package EMV2 {
    doc /* Avizienis/SHARD/EMV2 bottom-up service deviation metadata. */
    private import ISQ::*;

    metadata def Emv2ErrorSource { attribute errId : Str; attribute devClass : Emv2DeviationClass; attribute subQual : ShardSubQualifier; attribute baseRatePerS : Rate_PerS; }
    metadata def Emv2Propagation { attribute propId : Str; attribute inDev : Emv2DeviationClass; attribute outDev : Emv2DeviationClass; attribute portRef : Str; }
    metadata def Emv2Hyperedge { attribute edgeId : Str; attribute topology : HyperedgeTopology; attribute betaCcf : Dimensionless_Ratio; attribute groupRatePerS : Rate_PerS; }
  }

  package FMEDA {
    doc /* Coherent SI 4-way FMEDA metadata and rate conservation evaluator. */
    private import ISQ::*;

    metadata def FmedaMode {
      attribute fmId : Str;
      attribute severity : Int64;
      attribute alphaShare : Dimensionless_Ratio;
      attribute betaHaz : Dimensionless_Ratio;
      attribute dcPrimary : Dimensionless_Ratio;
      attribute dcLatent : Dimensionless_Ratio;
      attribute hft : Int64;
      attribute lambdaCompPerS : Rate_PerS;
      attribute ctmcSimplex : Bool = false;
    }

    calc def FmedaRowConserv {
      doc /* 4-way IEC 61508 rate conservation residual in s^-1. */
      in lambdaP : Rate_PerS;
      in alphaJ : Dimensionless_Ratio;
      in betaJ : Dimensionless_Ratio;
      in dcS : Dimensionless_Ratio;
      in dcJ : Dimensionless_Ratio;
      attribute lamJ : Rate_PerS = alphaJ * lambdaP;
      attribute lamSd : Rate_PerS = dcS * (1.0 - betaJ) * lamJ;
      attribute lamSu : Rate_PerS = (1.0 - dcS) * (1.0 - betaJ) * lamJ;
      attribute lamDd : Rate_PerS = dcJ * betaJ * lamJ;
      attribute lamDu : Rate_PerS = (1.0 - dcJ) * betaJ * lamJ;
      return conservErr : Rate_PerS = lamJ - (lamSd + lamSu + lamDd + lamDu);
    }
  }

  package FTA {
    doc /* Fault Tree gate metadata for MOCUS/ZBDD reduction. */
    private import ISQ::*;

    metadata def FaultTreeGate {
      attribute gateId : Str;
      attribute gateKind : FaultTreeGateKind;
      attribute kRequired : Int64 = 1;
      attribute nInputs : Int64 = 1;
      attribute ccfBeta : Dimensionless_Ratio = 0.0;
    }
  }

  package RTA {
    doc /* Runtime Assurance Simplex, CTMC, Risk Lattice, CRC-32C, and RMA evaluators. */
    private import ISQ::*;

    metadata def RtaSimplexMonitor {
      attribute monId : Str;
      attribute gammaDecayPerS : Rate_PerS;
      attribute tSwitchS : Duration_s;
      attribute tRollbackS : Duration_s;
      attribute hFloor : Dimensionless_Ratio;
    }

    metadata def RmaTask {
      attribute taskId : Str;
      attribute priority : Int64;
      attribute wcetS : Duration_s;
      attribute blockingS : Duration_s;
      attribute periodS : Duration_s;
      attribute deadlineS : Duration_s;
    }

    calc def Ctmc6StateCatProb {
      doc /* Conservative 6-state Kolmogorov CTMC catastrophic upper bound. */
      in lambdaPrim : Rate_PerS;
      in lambdaMon : Rate_PerS;
      in lambdaSw : Rate_PerS;
      in betaCcf : Dimensionless_Ratio;
      in dcMon : Dimensionless_Ratio;
      in tSwSimplex : Duration_s;
      in tRollback : Duration_s;
      in tMission : Duration_s;
      attribute lamTriad : Rate_PerS = lambdaPrim + lambdaMon + lambdaSw;
      attribute lamCcf : Rate_PerS = betaCcf * lamTriad;
      attribute lamIndP : Rate_PerS = (1.0 - betaCcf) * lambdaPrim;
      attribute lamIndM : Rate_PerS = (1.0 - betaCcf) * (lambdaMon + lambdaSw);
      attribute lamDdM : Rate_PerS = dcMon * lamIndM;
      attribute lamDuM : Rate_PerS = (1.0 - dcMon) * lamIndM;
      attribute muIso : Rate_PerS = 1.0 / tSwSimplex;
      attribute muRoll : Rate_PerS = 1.0 / tRollback;
      attribute pCcf : Dimensionless_Ratio = lamCcf * tMission;
      attribute pUniso : Dimensionless_Ratio = (lamIndP * lamIndM * tMission) / muIso;
      attribute pLat : Dimensionless_Ratio = 0.5 * lamDuM * lamIndP * tMission * tMission;
      attribute pExh : Dimensionless_Ratio =
        if (tRollback <= 0.5 * tMission)
        then ((lamIndM * (lamIndP + lamDdM) * tMission) / muRoll)
        else (0.5 * lamIndM * (lamIndP + lamDdM) * tMission * tMission);
      return pCatBound : Dimensionless_Ratio = pCcf + pUniso + pLat + pExh;
    }

    calc def RiskLatticePhi {
      doc /* Monotone order-theoretic risk lattice Phi_risk(S, E, C). */
      in sev : Int64;
      in exp : Int64;
      in ctrl : Int64;
      attribute maxEC : Int64 = if exp >= ctrl then exp else ctrl;
      attribute minEC : Int64 = if exp <= ctrl then exp else ctrl;
      attribute kappa : Int64 =
        if (maxEC == 4 and minEC >= 3) then 4
        else if ((exp == 3 and ctrl == 3) or (maxEC >= 3 and minEC == 2)) then 3
        else if ((exp == 2 and ctrl == 2) or (maxEC >= 3 and minEC == 1)) then 2
        else 1;
      return tier : TierLevel =
        if ((sev == 5 and kappa >= 3) or (sev == 4 and kappa == 4)) then TierLevel::Tier1
        else if ((sev == 5 and kappa <= 2) or (sev == 4 and kappa == 3) or (sev == 3 and kappa == 4)) then TierLevel::Tier2
        else if ((sev == 4 and kappa <= 2) or (sev == 3 and kappa == 3) or (sev == 2 and kappa == 4)) then TierLevel::Tier3
        else if ((sev == 3 and kappa <= 2) or (sev == 2 and kappa >= 2)) then TierLevel::Tier4
        else TierLevel::Tier5;
    }

    calc def Crc32cUndetectedRate {
      doc /* Castagnoli CRC-32C undetected corruption rate in s^-1 and watchdog bound in s. */
      in lPayloadBits : BitCount_bit;
      in rCrcBits : BitCount_bit;
      in fTx : Frequency_Hz;
      in pBitErr : Dimensionless_Ratio;
      in aMult : Dimensionless_Ratio;
      in dHamming : Int64;
      in nMiss : Int64;
      in tFrame : Duration_s;
      in tSw : Duration_s;
      attribute nCw : BitCount_bit = lPayloadBits + rCrcBits;
      attribute pUd : Dimensionless_Ratio = aMult * (pBitErr ^ 6) * ((1.0 - pBitErr) ^ 282);
      attribute tWd : Duration_s = nMiss * tFrame + tSw;
      return lambdaCorrupt : Rate_PerS = fTx * pUd;
    }

    calc def ZcbfFluxEval {
      doc /* ZCBF Nagumo-Brauer Lie-derivative barrier flux in s^-1. */
      in hVal : Dimensionless_Ratio;
      in lfH : Rate_PerS;
      in lgHU : Rate_PerS;
      in gammaDecay : Rate_PerS;
      return phiCbf : Rate_PerS = lfH + lgHU + gammaDecay * hVal;
    }

    calc def RmaUtilization {
      doc /* Priority-Ceiling RMA prefix processor utilization increment. */
      in prevUtil : Dimensionless_Ratio;
      in wcetS : Duration_s;
      in blockingS : Duration_s;
      in periodS : Duration_s;
      return uEff : Dimensionless_Ratio = prevUtil + (wcetS + blockingS) / periodS;
    }

    calc def RmaWcrtBound {
      doc /* Joseph-Pandya RMA worst-case response time step in s. */
      in wcetS : Duration_s;
      in blockingS : Duration_s;
      in hpInterferenceS : Duration_s;
      return wcrtNextS : Duration_s = wcetS + blockingS + hpInterferenceS;
    }

    calc def PhaseMarginEff {
      doc /* Transport-delay closed-loop effective phase margin in rad. */
      in phi0Rad : PhaseAngle_rad;
      in omegaCRadPerS : AngularRate_rad_per_s;
      in rActS : Duration_s;
      in tActS : Duration_s;
      attribute lDelayS : Duration_s = rActS + tActS;
      attribute deltaPhiLagRad : PhaseAngle_rad = omegaCRadPerS * lDelayS;
      return phiEffRad : PhaseAngle_rad = phi0Rad - deltaPhiLagRad;
    }
  }
}
