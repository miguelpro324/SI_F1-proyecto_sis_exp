/**
 * @file main.cpp
 * @brief CLI application for diabetes diagnosis expert system
 * 
 * Prompts user for patient biomarker data, executes CLIPS inference engine,
 * and displays the diagnostic conclusion.
 */

#include "InferenceEngine.hpp"
#include <iostream>
#include <limits>
#include <string>

/**
 * @brief Clear input stream on error
 */
void clearInputStream() {
    std::cin.clear();
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

/**
 * @brief Main entry point for the diabetes diagnosis CLI
 */
int main() {
    std::cout << "========================================" << std::endl;
    std::cout << "  DIABETES DIAGNOSIS EXPERT SYSTEM" << std::endl;
    std::cout << "  Rule-Based Medical Inference Engine" << std::endl;
    std::cout << "========================================" << std::endl;
    std::cout << std::endl;

    // Create the inference engine wrapper
    InferenceEngine engine;
    
    if (!engine.isValid()) {
        std::cerr << "FATAL: Failed to initialize CLIPS inference engine" << std::endl;
        return 1;
    }

    // Define the knowledge base file paths in strict load order
    std::vector<std::string> knowledgeBaseFiles = {
        "knowledge_base/00_templates.clp",
        "knowledge_base/01_validation.clp",
        "knowledge_base/02_abstraction.clp",
        "knowledge_base/03_diagnostic.clp"
    };

    // Load the knowledge base
    if (!engine.loadKnowledgeBase(knowledgeBaseFiles)) {
        std::cerr << "FATAL: Failed to load knowledge base" << std::endl;
        return 1;
    }

    // Reset the environment (prepares for fact assertion)
    if (!engine.reset()) {
        std::cerr << "FATAL: Failed to reset CLIPS environment" << std::endl;
        return 1;
    }

    // Prompt for patient data
    std::cout << "\n--- Patient Data Entry ---" << std::endl;
    
    int patientId;
    std::cout << "Enter Patient ID: ";
    while (!(std::cin >> patientId)) {
        std::cout << "Invalid input. Please enter an integer Patient ID: ";
        clearInputStream();
    }

    float fpg;
    std::cout << "Enter Fasting Plasma Glucose (FPG) in mg/dL: ";
    while (!(std::cin >> fpg)) {
        std::cout << "Invalid input. Please enter a numeric FPG value: ";
        clearInputStream();
    }

    float hba1c;
    std::cout << "Enter Hemoglobin A1c (HbA1c) in %: ";
    while (!(std::cin >> hba1c)) {
        std::cout << "Invalid input. Please enter a numeric HbA1c value: ";
        clearInputStream();
    }

    std::cout << "\n--- Data Summary ---" << std::endl;
    std::cout << "Patient ID: " << patientId << std::endl;
    std::cout << "FPG: " << fpg << " mg/dL" << std::endl;
    std::cout << "HbA1c: " << hba1c << "%" << std::endl;
    std::cout << std::endl;

    // Assert patient data into working memory
    if (!engine.assertPatientData(patientId, fpg, hba1c)) {
        std::cerr << "ERROR: Failed to assert patient data" << std::endl;
        return 1;
    }

    // Assert initial system state to trigger the inference chain
    if (!engine.assertSystemState("validation")) {
        std::cerr << "ERROR: Failed to assert system state" << std::endl;
        return 1;
    }

    // Execute the inference engine
    long rulesFired = engine.run();
    
    if (rulesFired == 0) {
        std::cout << "WARNING: No rules were fired. Check knowledge base logic." << std::endl;
    }

    // Display the final diagnosis
    engine.printDiagnosis();

    std::cout << "\nProgram completed successfully." << std::endl;
    return 0;
}
