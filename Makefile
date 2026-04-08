# Makefile for Diabetes Expert System
# Supports building with system CLIPS library or CLIPS source files

CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2
TARGET = diabetes_expert_system

# Source files
CPP_SOURCES = src/main.cpp src/InferenceEngine.cpp
CLIPS_SOURCE_DIR = external/clips/core

# Default target: try to build with system CLIPS library
all: check-clips
	@echo "Building with system CLIPS library..."
	$(CXX) $(CXXFLAGS) $(CPP_SOURCES) -lclips -lm -o $(TARGET)
	@echo "Build successful! Run with: ./$(TARGET)"

# Build with CLIPS source files (if available)
with-source:
	@if [ ! -d "$(CLIPS_SOURCE_DIR)" ]; then \
		echo "ERROR: CLIPS source not found at $(CLIPS_SOURCE_DIR)"; \
		echo "Please download CLIPS 6.40 from SourceForge and extract to external/clips/core/"; \
		exit 1; \
	fi
	@echo "Building with CLIPS source files..."
	$(CXX) $(CXXFLAGS) $(CPP_SOURCES) $(CLIPS_SOURCE_DIR)/*.c -I$(CLIPS_SOURCE_DIR) -lm -o $(TARGET)
	@echo "Build successful! Run with: ./$(TARGET)"

# Check if CLIPS library is available
check-clips:
	@echo "Checking for CLIPS library..."
	@if ! ldconfig -p | grep -q libclips; then \
		echo "WARNING: CLIPS library not found in system."; \
		echo "Attempting to build with source files..."; \
		$(MAKE) with-source; \
	fi

# Test the expert system with sample data
test: all
	@echo ""
	@echo "========== TEST CASE 1: Type 2 Diabetes =========="
	@echo "1001\n145.0\n7.2" | ./$(TARGET)
	@echo ""
	@echo "========== TEST CASE 2: Prediabetes =========="
	@echo "1002\n110.0\n6.0" | ./$(TARGET)
	@echo ""
	@echo "========== TEST CASE 3: Normal =========="
	@echo "1003\n90.0\n5.2" | ./$(TARGET)

# Clean build artifacts
clean:
	rm -f $(TARGET)
	@echo "Cleaned build artifacts"

# Display help
help:
	@echo "Diabetes Expert System - Build Options"
	@echo ""
	@echo "Targets:"
	@echo "  make              - Build with system CLIPS library (default)"
	@echo "  make with-source  - Build with CLIPS source files"
	@echo "  make test         - Build and run test cases"
	@echo "  make clean        - Remove build artifacts"
	@echo "  make help         - Show this help message"
	@echo ""
	@echo "Requirements:"
	@echo "  - CLIPS library (libclips) OR CLIPS source files in external/clips/core/"
	@echo "  - g++ with C++17 support"

.PHONY: all with-source check-clips test clean help
