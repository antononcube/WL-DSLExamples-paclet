BeginTestSection["DSLWorkflowSeparators"];

Needs["AntonAntonov`DSLExamples`"];

VerificationTest[
  DSLExamples["Language" -> "WL", "Workflow" -> All],
  _Association,
  SameTest -> MatchQ,
  TestID -> "DSLExamples-WL"
];

VerificationTest[
  DSLExamples["Language" -> "Python", "Workflow" -> All],
  _Association,
  SameTest -> MatchQ,
  TestID -> "DSLExamples-Python"
];

VerificationTest[
  DSLExamples["Language" -> "R", "Workflow" -> All],
  _Association,
  SameTest -> MatchQ,
  TestID -> "DSLExamples-R"
];

VerificationTest[
  DSLExamples["Language" -> "Raku", "Workflow" -> All],
  _Association,
  SameTest -> MatchQ,
  TestID -> "DSLExamples-Raku"
];

EndTestSection[];
