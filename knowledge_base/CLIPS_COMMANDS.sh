#!/bin/bash
# CLIPS Execution Script for Diabetes Expert System
# Pure CLIPS implementation (no C++ wrapper)
#
# Instructions:
# 1. Start CLIPS: clips
# 2. Copy and paste the commands below into the CLIPS console
# 3. Follow the prompts to enter patient data
# 4. Review the diagnostic report

# ============================================================================
# EXACT COMMANDS TO TYPE INTO CLIPS CONSOLE
# ============================================================================

# Load all knowledge base files in the correct order
(batch knowledge_base/00_templates.clp)
(batch knowledge_base/01_validation.clp)
(batch knowledge_base/02_abstraction.clp)
(batch knowledge_base/03_diagnostic.clp)
(batch knowledge_base/04_cli.clp)

# Reset the environment and assert (initial-fact)
(reset)

# Run the inference engine
(run)

# ============================================================================
# ALTERNATIVE: One-liner (paste directly)
# ============================================================================

# If your CLIPS installation supports it, you can paste this single command:
# (batch knowledge_base/00_templates.clp) (batch knowledge_base/01_validation.clp) (batch knowledge_base/02_abstraction.clp) (batch knowledge_base/03_diagnostic.clp) (batch knowledge_base/04_cli.clp) (reset) (run)

# ============================================================================
# TROUBLESHOOTING
# ============================================================================

# If you get "File not found" errors:
# 1. Make sure you are in the project root directory
# 2. Type: (chdir "path/to/project/directory")
# 3. Then load the files

# To check the current directory in CLIPS:
# (getenv "PWD")

# To manually assert a patient (if needed):
# (assert (patient (id 1001) (fpg 145.0) (hba1c 7.2)))
# (assert (system-state (phase validation)))

# To view all facts in working memory:
# (facts)

# To view all defrules:
# (rules)

# To stop the inference engine:
# Ctrl+C in most CLIPS environments
