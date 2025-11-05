# DSLExamples

Wolfram Language paclet with Domain Specific Language (DSL) examples (suitable for LLM translations.)

----

## Installation & load

To install this paclet in your Wolfram Language environment, evaluate this code:

```mathematica
PacletInstall["AntonAntonov/DSLExamples"]
```

To load the code after installation, evaluate this code:

```mathematica
Needs["AntonAntonov`DSLExamples`"]
```

----

## Usage examples

Show a few of the examples for the Latent Semantic Analysis (LSA) software monad written in Wolfram Language (WL):

```mathematica
DSLExamples["WL", "LSAMon"][[1 ;; 4]]
```

```
 <|"install the package" -> "PacletInstall[\"AntonAntonov/MonadicLatentSemanticAnalysis\"]", 
   "load the package" -> "Needs[\"AntonAntonov`MonadicLatentSemanticAnalysis`\"]", 
   "use the documents aDocs" -> "LSAMonUnit[aDocs]", 
   "use dfTemp" -> "LSAMonUnit[dfTemp]"|>
```

Here is a function that makes a few-shot training LLM function for given programming language and workflow name:

```mathematica
LLMPipelineSegment[lang_String : "WL", workflow_String : "LSAMon"] := 
	LLMExampleFunction[Normal@DSLExamples[lang, workflow]];
```

---

Here is a list of natural language commands specifying an LSA workflow:

```mathematica
commands = {
	"use the dataset aAbstracts", 
	"make the document-term matrix without stemming", 
	"exract 40 topics using the method non-negative matrix factorization", 
	"show the topics"
	};
```

Translate those commands -- line by line -- into of a monadic pipeline for the paclet ["AntonAntonov/MonadicLatentSemanticAnalysis"](https://resources.wolframcloud.com/PacletRepository/resources/AntonAntonov/MonadicLatentSemanticAnalysis/) :

```mathematica
StringRiffle[
	LLMPipelineSegment["WL", "LSAMon"] /@ commands, 
	"⟹\n"
	]
```

```
LSAMonUnit[aAbstracts]⟹
LSAMonMakeDocumentTermMatrix["StemmingRules"->{}, "StopWords"->Automatic]⟹
LSAMonExtractTopics["NumberOfTopics"->40, Method->"NNMF"]⟹
LSAMonEchoTopicsTable[]
```

Instead of translating the commands line-by-line do an en bloc translation:

```mathematica
LLMPipelineSegment[][commands]
```

```
LSAMonUnit[aAbstracts]⟹
LSAMonMakeDocumentTermMatrix["StemmingRules"->{}, "StopWords"->Automatic]⟹
LSAMonExtractTopics["NumberOfTopics"->40, Method->"NNMF"]⟹
LSAMonEchoTopicsTable[]
```

----

## References

[AAp1] Anton Antonov,
[DSL::Examples, Raku package](https://github.com/antononcube/Raku-DSL-Examples),
(2024-2025),
[GitHub/antononcube](https://github.com/antononcube).