standard library package ISQ {
  doc /* Coherent Z^7 International System of Quantities and IEC info units. */

  public import SI::*;
  public import InfoUnits::*;

  datatype Real64;
  datatype Int64;
  datatype Bool;
  datatype Str;

  metadata def SiUnit {
    doc /* Affine-free coherent SI unit descriptor (alpha = 1.0, beta = 0.0). */
    attribute symbol : Str;
    attribute dimL : Int64 = 0;
    attribute dimM : Int64 = 0;
    attribute dimT : Int64 = 0;
    attribute dimI : Int64 = 0;
    attribute dimTheta : Int64 = 0;
    attribute dimN : Int64 = 0;
    attribute dimJ : Int64 = 0;
    attribute alpha : Real64 = 1.0;
    attribute beta : Real64 = 0.0;
  }

  metadata def InfoUnit {
    doc /* Discrete information quantity descriptor in bytes, bits, or counts. */
    attribute symbol : Str;
    attribute radix : Int64 = 2;
    attribute dimT : Int64 = 0;
    attribute alpha : Real64 = 1.0;
    attribute beta : Real64 = 0.0;
  }

  package SI {
    doc /* Coherent SI scalar quantity types with zero affine offset. */

    attribute def Dimensionless_Ratio :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "1"; }
    }

    attribute def Duration_s :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "s"; dimT = 1; }
    }

    attribute def Frequency_Hz :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "Hz"; dimT = -1; }
    }

    attribute def Rate_PerS :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "s^-1"; dimT = -1; }
    }

    attribute def Temperature_K :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "K"; dimTheta = 1; }
    }

    attribute def PhaseAngle_rad :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "rad"; }
    }

    attribute def AngularRate_rad_per_s :> ISQ::Real64 {
      @ISQ::SiUnit { symbol = "rad/s"; dimT = -1; }
    }
  }

  package InfoUnits {
    doc /* Discrete information units and coherent byte throughput rates. */

    attribute def ByteCount_B :> ISQ::Int64 {
      @ISQ::InfoUnit { symbol = "B"; radix = 2; }
    }

    attribute def BitCount_bit :> ISQ::Int64 {
      @ISQ::InfoUnit { symbol = "bit"; radix = 2; }
    }

    attribute def ByteRate_B_per_s :> ISQ::Real64 {
      @ISQ::InfoUnit { symbol = "B/s"; radix = 2; dimT = -1; }
    }

    attribute def TokenCount :> ISQ::Int64 {
      @ISQ::InfoUnit { symbol = "1"; radix = 10; }
    }

    attribute def LineCount :> ISQ::Int64 {
      @ISQ::InfoUnit { symbol = "1"; radix = 10; }
    }
  }
}
