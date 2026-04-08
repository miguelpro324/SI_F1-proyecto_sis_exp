/**
 * @file InferenceEngine.hpp
 * @brief C++ Wrapper for CLIPS C API - Manages the expert system inference engine
 * 
 * This class encapsulates CLIPS environment lifecycle management, rule loading,
 * fact assertion, and inference execution for the diabetes diagnosis system.
 */

#ifndef INFERENCE_ENGINE_HPP
#define INFERENCE_ENGINE_HPP

#include <string>
#include <vector>

// Forward declare CLIPS environment pointer to avoid header pollution
extern "C" {
    typedef struct environment Environment;
}

class InferenceEngine {
public:
    /**
     * @brief Constructor - creates a new CLIPS environment
     */
    InferenceEngine();

    /**
     * @brief Destructor - releases CLIPS environment resources
     */
    ~InferenceEngine();

    // Prevent copying (CLIPS environment is not copyable)
    InferenceEngine(const InferenceEngine&) = delete;
    InferenceEngine& operator=(const InferenceEngine&) = delete;

    /**
     * @brief Load CLIPS rule files in specified order
     * @param filePaths Vector of .clp file paths (must be in dependency order)
     * @return true if all files loaded successfully
     */
    bool loadKnowledgeBase(const std::vector<std::string>& filePaths);

    /**
     * @brief Reset the CLIPS environment and activate the initial fact
     * @return true if reset successful
     */
    bool reset();

    /**
     * @brief Assert a patient fact into working memory
     * @param patientId Unique patient identifier
     * @param fpg Fasting Plasma Glucose (mg/dL)
     * @param hba1c Hemoglobin A1c (%)
     * @return true if assertion successful
     */
    bool assertPatientData(int patientId, float fpg, float hba1c);

    /**
     * @brief Assert the initial system-state fact to start the inference chain
     * @param initialPhase Starting phase (typically "validation")
     * @return true if assertion successful
     */
    bool assertSystemState(const std::string& initialPhase);

    /**
     * @brief Execute the inference engine (run all activated rules)
     * @param maxRules Maximum number of rules to fire (-1 for unlimited)
     * @return Number of rules fired
     */
    long run(long maxRules = -1);

    /**
     * @brief Extract and display the final diagnosis from working memory
     */
    void printDiagnosis() const;

    /**
     * @brief Check if the CLIPS environment is valid
     * @return true if environment pointer is non-null
     */
    bool isValid() const { return m_env != nullptr; }

private:
    void* m_env;  ///< CLIPS environment pointer (opaque handle)

    /**
     * @brief Assert a generic fact string into CLIPS
     * @param factString CLIPS fact syntax string
     * @return true if assertion successful
     */
    bool assertFact(const std::string& factString);
};

#endif // INFERENCE_ENGINE_HPP
