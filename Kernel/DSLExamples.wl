
BeginPackage["AntonAntonov`DSLExamples`"];

GetDSLExamples::usage="Obtain DSL examples for a given file location (path or URL.)";

DSLExamples::usage="Retrieve DSL examples for specified programming language and workflow name.";

GetDSLWorkflowSeparators::usage="Obtain DSL workflow commands separators for a given file location (path or URL.)";

DSLWorkflowSeparators::usage="Retrieve DSL the workflow commands separator(s) for specified programming language and workflow name.";

Begin["`Private`"];

(*******************************************************)
(* GetDSLExamples                                      *)
(*******************************************************)
Clear[GetDSLExamples];

GetDSLExamples[] := GetDSLExamples[] =
Block[{dirName, fileName},
    dirName = First[PacletFind["AntonAntonov/DSLExamples"]]["Location"];
    fileName = FileNameJoin[{dirName, "Kernel", "dsl-examples.json"}];
    GetDSLExamples[fileName]
];
GetDSLExamples[url:(_File|_String|_URL)] := GetDSLExamples[]=Normal@Import[url,"Dataset"];

(*******************************************************)
(* DSLExamples                                         *)
(*******************************************************)
Clear[DSLExamples];

DSLExamples::nlang = "The language value is expected to be All, Automatic, or a string, one of `1`.";
DSLExamples::unlang = "Unknown programming language `1`.";
DSLExamples::nwf = "The workflow value is expected to be a All or a string.";
DSLExamples::unwf = "Unknown workflow `1`.";

Options[DSLExamples] = {"Language" -> All, "Workflow" -> All};

DSLExamples[opts : OptionsPattern[]] := DSLExamples[OptionValue[DSLExamples, "Language"], OptionValue[DSLExamples, "Workflow"]];

DSLExamples[langArg_ : All, workflowArg_ : All] :=
  Block[{lang = langArg, workflow = workflowArg, aExamples, res, t},
   
   aExamples = GetDSLExamples[];
   
   If[TrueQ[lang === Automatic], lang = "WL"];

   If[! (StringQ[lang] || TrueQ[lang === All]),
     Message[DSLExamples::unlang, "\"" <> StringRiffle[Keys[aExamples], "\", \""] <> "\""];
     Return[$Failed]
   ];
   
   If[StringQ[lang] && !KeyExistsQ[aExamples, lang],
     Message[DSLExamples::unlang, "\"" <> lang <> "\""];
     Return[None]
   ];

   If[! (StringQ[workflow] || TrueQ[workflow === All]),
     Message[DSLExamples::nwf];
     Return[$Failed]
   ];
   
   res =
    Switch[
     {lang, workflow},
     
     {All, All}, aExamples,
     
     {_String, All}, Lookup[aExamples, lang, None],
     
     {All, _String}, 
     Association @@ KeyValueMap[#1 -> Lookup[#2, workflow, None] &, aExamples],
     
     {_String, _String},
     t = Lookup[aExamples, lang, None];
     If[AssociationQ[t], Lookup[t, workflow, None]],
     
     _, aExamples
    ];
   
   If[TrueQ[res === None], Message[DSLExamples::unwf, workflow]];
   res
];


(*******************************************************)
(* GetDSLWorkflowSeparators                            *)
(*******************************************************)
Clear[GetDSLWorkflowSeparators];

GetDSLWorkflowSeparators[] := GetDSLWorkflowSeparators[] =
Block[{dirName, fileName},
    dirName = First[PacletFind["AntonAntonov/DSLExamples"]]["Location"];
    fileName = FileNameJoin[{dirName, "Kernel", "dsl-workflow-separators.json"}];
    GetDSLWorkflowSeparators[fileName]
];
GetDSLWorkflowSeparators[url:(_File|_String|_URL)] := GetDSLWorkflowSeparators[]=Normal@Import[url,"Dataset"];

(*******************************************************)
(* DSLWorkflowSeparators                               *)
(*******************************************************)
(* This can be refactored but I am how much better that refactored is going to be. *)
(* Ideally this done by manipulating the down values. *)

Clear[DSLWorkflowSeparators];

DSLWorkflowSeparators::nlang = "The language value is expected to be All, Automatic, or a string, one of `1`.";
DSLWorkflowSeparators::unlang = "Unknown programming language `1`.";
DSLWorkflowSeparators::nwf = "The workflow value is expected to be a All or a string.";
DSLWorkflowSeparators::unwf = "Unknown workflow `1`.";

Options[DSLWorkflowSeparators] = {"Language" -> All, "Workflow" -> All};

DSLWorkflowSeparators[opts : OptionsPattern[]] := DSLWorkflowSeparators[OptionValue[DSLWorkflowSeparators, "Language"], OptionValue[DSLWorkflowSeparators, "Workflow"]];

DSLWorkflowSeparators[langArg_ : All, workflowArg_ : All] :=
  Block[{lang = langArg, workflow = workflowArg, aExamples, res, t},
   
   aExamples = GetDSLWorkflowSeparators[];
   
   If[TrueQ[lang === Automatic], lang = "WL"];

   If[! (StringQ[lang] || TrueQ[lang === All]),
     Message[DSLWorkflowSeparators::unlang, "\"" <> StringRiffle[Keys[aExamples], "\", \""] <> "\""];
     Return[$Failed]
   ];
   
   If[StringQ[lang] && !KeyExistsQ[aExamples, lang],
     Message[DSLWorkflowSeparators::unlang, "\"" <> lang <> "\""];
     Return[None]
   ];

   If[! (StringQ[workflow] || TrueQ[workflow === All]),
     Message[DSLWorkflowSeparators::nwf];
     Return[$Failed]
   ];
   
   res =
    Switch[
     {lang, workflow},
     
     {All, All}, aExamples,
     
     {_String, All}, Lookup[aExamples, lang, None],
     
     {All, _String}, 
     Association @@ KeyValueMap[#1 -> Lookup[#2, workflow, None] &, aExamples],
     
     {_String, _String},
     t = Lookup[aExamples, lang, None];
     If[AssociationQ[t], Lookup[t, workflow, None]],
     
     _, aExamples
    ];
   
   If[TrueQ[res === None], Message[DSLWorkflowSeparators::unwf, workflow]];
   res
];

End[];
EndPackage[];
