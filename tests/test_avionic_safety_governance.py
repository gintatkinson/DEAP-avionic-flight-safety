"""
DEAP Civil Avionic Flight Safety Platform — Governance & Verification Test Suite
"""

from pathlib import Path
import pytest

REPO_ROOT = Path(__file__).parent.parent
SSOT_BLUEPRINTS = REPO_ROOT.parent / "DEAP-spec-core" / "docs" / "architecture" / "blueprints"

def test_repository_structure_exists():
    assert (REPO_ROOT / "README.md").exists()
    assert (REPO_ROOT / ".pipeline" / "constitution.md").exists()
    assert (REPO_ROOT / ".pipeline" / "profiles" / "spark_ada.md").exists()
    assert (REPO_ROOT / ".pipeline" / "profiles" / "embedded_c.md").exists()
    assert (REPO_ROOT / ".agents" / "AGENTS.md").exists()
    assert (REPO_ROOT / "docs" / "architecture" / "blueprints" / "DEAP_FLIGHT_SYSTEMS_SAFETY_CONCEPT_PAPER.md").exists()
    assert (SSOT_BLUEPRINTS / "DEAP_SYSML_V2_SAFETY_MODEL_SPECIFICATION.sysml").exists()
    assert (SSOT_BLUEPRINTS / "DEAP_SYSML_V2_SAFETY_MODEL_SPECIFICATION.md").exists()

def test_concept_paper_contains_regulatory_frameworks():
    concept_paper = (REPO_ROOT / "docs" / "architecture" / "blueprints" / "DEAP_FLIGHT_SYSTEMS_SAFETY_CONCEPT_PAPER.md").read_text()
    assert "DO-178C" in concept_paper
    assert "DO-254" in concept_paper
    assert "ARP4754A" in concept_paper
    assert "ARP4761" in concept_paper
    assert "STPA" in concept_paper
    assert "FMECA" in concept_paper

def test_sysml_v2_model_contains_packages():
    sysml_model = (SSOT_BLUEPRINTS / "DEAP_SYSML_V2_SAFETY_MODEL_SPECIFICATION.sysml").read_text()
    assert "package DEAP_Safety_Architecture" in sysml_model
    assert "package Certification_Requirements" in sysml_model
    assert "requirement def DO178C_DAL_A" in sysml_model

def test_spark_ada_profile_zero_heap_mandate():
    profile = (REPO_ROOT / ".pipeline" / "profiles" / "spark_ada.md").read_text()
    assert "No_Implicit_Heap_Allocations" in profile
    assert "GNATprove" in profile
    assert "100% Modified Condition/Decision Coverage" in profile

def test_embedded_c_profile_misra_mandate():
    profile = (REPO_ROOT / ".pipeline" / "profiles" / "embedded_c.md").read_text()
    assert "MISRA-C:2012" in profile
    assert "ARINC 653" in profile
    assert "malloc" in profile
