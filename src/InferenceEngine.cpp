/**
 * @file InferenceEngine.cpp
 * @brief Implementation of CLIPS C API wrapper for diabetes diagnosis system
 */

#include "InferenceEngine.hpp"
#include <iostream>
#include <sstream>
#include <iomanip>

// Include CLIPS C API headers
extern "C" {
    #include "clips.h"
}

InferenceEngine::InferenceEngine() : m_env(nullptr) {
    // Create a new CLIPS environment instance
    m_env = CreateEnvironment();
    if (!m_env) {
        std::cerr << "FATAL: Failed to create CLIPS environment" << std::endl;
    }
}

InferenceEngine::~InferenceEngine() {
    // Release CLIPS environment resources
    if (m_env) {
        DestroyEnvironment(m_env);
        m_env = nullptr;
    }
}

bool InferenceEngine::loadKnowledgeBase(const std::vector<std::string>& filePaths) {
    if (!isValid()) {
        std::cerr << "ERROR: Invalid CLIPS environment" << std::endl;
        return false;
    }

    // Load each .clp file in the specified order (dependency-aware)
    for (const auto& path : filePaths) {
        std::cout << "Loading knowledge base: " << path << std::endl;
        
        // EnvLoad returns 1 on success, 0 on failure
        if (EnvLoad(m_env, path.c_str()) == 0) {
            std::cerr << "ERROR: Failed to load " << path << std::endl;
            return false;
        }
    }

    std::cout << "Knowledge base loaded successfully (" << filePaths.size() << " files)" << std::endl;
    return true;
}

bool InferenceEngine::reset() {
    if (!isValid()) {
        std::cerr << "ERROR: Invalid CLIPS environment" << std::endl;
        return false;
    }

    // Reset the environment (clears working memory and asserts initial-fact)
    EnvReset(m_env);
    std::cout << "CLIPS environment reset" << std::endl;
    return true;
}

bool InferenceEngine::assertPatientData(int patientId, float fpg, float hba1c) {
    // Construct CLIPS fact string using template syntax
    std::ostringstream factStream;
    factStream << std::fixed << std::setprecision(2);
    factStream << "(patient (id " << patientId 
               << ") (fpg " << fpg 
               << ") (hba1c " << hba1c << "))";
    
    return assertFact(factStream.str());
}

bool InferenceEngine::assertSystemState(const std::string& initialPhase) {
    // Assert the system-state control fact
    std::string factString = "(system-state (phase " + initialPhase + "))";
    return assertFact(factString);
}

bool InferenceEngine::assertFact(const std::string& factString) {
    if (!isValid()) {
        std::cerr << "ERROR: Invalid CLIPS environment" << std::endl;
        return false;
    }

    // Assert the fact string into working memory
    // EnvAssertString returns NULL on failure
    void* factPtr = EnvAssertString(m_env, factString.c_str());
    if (!factPtr) {
        std::cerr << "ERROR: Failed to assert fact: " << factString << std::endl;
        return false;
    }

    std::cout << "Asserted: " << factString << std::endl;
    return true;
}

long InferenceEngine::run(long maxRules) {
    if (!isValid()) {
        std::cerr << "ERROR: Invalid CLIPS environment" << std::endl;
        return 0;
    }

    std::cout << "\n========== STARTING INFERENCE ENGINE ==========" << std::endl;
    
    // Execute the inference engine (fires rules until agenda is empty or limit reached)
    // Returns the number of rules that fired
    long rulesFired = EnvRun(m_env, maxRules);
    
    std::cout << "========== INFERENCE COMPLETE ==========" << std::endl;
    std::cout << "Total rules fired: " << rulesFired << std::endl;
    
    return rulesFired;
}

void InferenceEngine::printDiagnosis() const {
    if (!isValid()) {
        std::cerr << "ERROR: Invalid CLIPS environment" << std::endl;
        return;
    }

    std::cout << "\n========== DIAGNOSIS REPORT ==========" << std::endl;

    // Query working memory for diagnosis facts
    // Build a query to find all diagnosis facts
    std::string queryString = "(diagnosis (patient-id ?pid) (classification ?class) (justification ?just))";
    
    // Use EnvFindDeftemplate to get the diagnosis template
    void* diagnosisTemplate = EnvFindDeftemplate(m_env, "diagnosis");
    if (!diagnosisTemplate) {
        std::cout << "No diagnosis template found in working memory" << std::endl;
        return;
    }

    // Get the first fact of type diagnosis
    void* factPtr = EnvGetNextFact(m_env, nullptr);
    bool diagnosisFound = false;

    while (factPtr != nullptr) {
        // Get the template of this fact
        void* factTemplate = EnvFactDeftemplate(m_env, factPtr);
        
        // Check if this fact is a diagnosis fact
        if (factTemplate == diagnosisTemplate) {
            diagnosisFound = true;
            
            // Extract slot values using EnvGetFactSlot
            DATA_OBJECT slotValue;
            
            // Get patient-id
            EnvGetFactSlot(m_env, factPtr, "patient-id", &slotValue);
            long patientId = DOToLong(slotValue);
            
            // Get classification
            EnvGetFactSlot(m_env, factPtr, "classification", &slotValue);
            const char* classification = DOToString(slotValue);
            
            // Get justification
            EnvGetFactSlot(m_env, factPtr, "justification", &slotValue);
            const char* justification = DOToString(slotValue);
            
            std::cout << "Patient ID: " << patientId << std::endl;
            std::cout << "Classification: " << classification << std::endl;
            std::cout << "Justification: " << justification << std::endl;
            std::cout << "======================================" << std::endl;
        }
        
        // Move to next fact
        factPtr = EnvGetNextFact(m_env, factPtr);
    }

    if (!diagnosisFound) {
        std::cout << "No diagnosis facts found in working memory." << std::endl;
        std::cout << "The inference engine may have encountered an error or invalid data." << std::endl;
    }
}
