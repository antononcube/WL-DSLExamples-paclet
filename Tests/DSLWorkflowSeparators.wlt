BeginTestSection["DSLWorkflowSeparators"];

Needs["AntonAntonov`DSLExamples`"];

(* Test 1: Default arguments {All, All} *)
VerificationTest[
    DSLWorkflowSeparators[],
    _Association,
    SameTest -> MatchQ,
    TestID -> "DefaultArgs"
];

VerificationTest[
    DSLWorkflowSeparators[All, All],
    _Association,
    SameTest -> MatchQ,
    TestID -> "AllAll"
];

(* Test 2: Automatic Handling *)
VerificationTest[
    DSLWorkflowSeparators[Automatic],
    DSLWorkflowSeparators["WL"],
    TestID -> "AutomaticLang"
];

(* Test 3: Specific Language {String, All} *)
VerificationTest[
    DSLWorkflowSeparators["WL"],
    _Association,
    SameTest -> MatchQ,
    TestID -> "SpecificLang_WL"
];

VerificationTest[
    DSLWorkflowSeparators["WL", All],
    DSLWorkflowSeparators["WL"],
    TestID -> "SpecificLang_WL_All"
];

(* Test 4: Specific Workflow {All, String} *)
(* Assuming "DataReshaping" exists in multiple languages or at least one *)
VerificationTest[
    DSLWorkflowSeparators[All, "DataReshaping"],
    _Association,
    SameTest -> MatchQ,
    TestID -> "SpecificWorkflow"
];

(* Test 5: Specific Language and Workflow {String, String} *)
(* Based on dsl-workflow-separators.json content *)
VerificationTest[
    DSLWorkflowSeparators["WL", "DataReshaping"],
    ";\n",
    TestID -> "SpecificLangWorkflow"
];

(* Test 6: Options Handling *)
VerificationTest[
    DSLWorkflowSeparators["Language" -> "R", "Workflow" -> "SMRMon"],
    DSLWorkflowSeparators["R", "SMRMon"],
    TestID -> "OptionsHandling"
];

(* Test 7: Error Handling - Invalid Language *)
(* Should return None and issue message *)
VerificationTest[
    DSLWorkflowSeparators["NonExistentLanguage"],
    None,
    {DSLWorkflowSeparators::unlang},
    TestID -> "InvalidLang"
];

(* Test 8: Error Handling - Invalid Workflow *)
(* Should return None and issue message *)
VerificationTest[
    DSLWorkflowSeparators["WL", "NonExistentWorkflow"],
    None,
    {DSLWorkflowSeparators::unwf},
    TestID -> "InvalidWorkflow"
];

(* Test 9: Error Handling - Invalid Arguments Types *)
VerificationTest[
    DSLWorkflowSeparators[123],
    $Failed,
    {DSLWorkflowSeparators::unlang},
    TestID -> "InvalidLangType"
];

VerificationTest[
    DSLWorkflowSeparators["WL", 123],
    $Failed,
    {DSLWorkflowSeparators::nwf},
    TestID -> "InvalidWorkflowType"
];

EndTestSection[];