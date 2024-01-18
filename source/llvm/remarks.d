/+
+            Copyright 2023 – 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.remarks;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

enum REMARKS_API_VERSION = 1;

alias LLVMRemarkType = int;
enum: LLVMRemarkType{
	LLVMRemarkTypeUnknown,
	LLVMRemarkTypePassed,
	LLVMRemarkTypeMissed,
	LLVMRemarkTypeAnalysis,
	LLVMRemarkTypeAnalysisFPCommute,
	LLVMRemarkTypeAnalysisAliasing,
	LLVMRemarkTypeFailure,
};

struct LLVMRemarkOpaqueString;
alias LLVMRemarkStringRef = LLVMRemarkOpaqueString*;

struct LLVMRemarkOpaqueDebugLoc;
alias LLVMRemarkDebugLocRef = LLVMRemarkOpaqueDebugLoc*;

struct LLVMRemarkOpaqueArg;
alias LLVMRemarkArgRef = LLVMRemarkOpaqueArg*;

struct LLVMRemarkOpaqueEntry;
alias LLVMRemarkEntryRef = LLVMRemarkOpaqueEntry*;

struct LLVMRemarkOpaqueParser;
alias LLVMRemarkParserRef = LLVMRemarkOpaqueParser*;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{const(char)*}, q{LLVMRemarkStringGetData}, q{LLVMRemarkStringRef string}},
		{q{uint}, q{LLVMRemarkStringGetLen}, q{LLVMRemarkStringRef string}},
		{q{LLVMRemarkStringRef}, q{LLVMRemarkDebugLocGetSourceFilePath}, q{LLVMRemarkDebugLocRef dl}},
		{q{uint}, q{LLVMRemarkDebugLocGetSourceLine}, q{LLVMRemarkDebugLocRef dl}},
		{q{uint}, q{LLVMRemarkDebugLocGetSourceColumn}, q{LLVMRemarkDebugLocRef dl}},
		{q{LLVMRemarkStringRef}, q{LLVMRemarkArgGetKey}, q{LLVMRemarkArgRef arg}},
		{q{LLVMRemarkStringRef}, q{LLVMRemarkArgGetValue}, q{LLVMRemarkArgRef arg}},
		{q{LLVMRemarkDebugLocRef}, q{LLVMRemarkArgGetDebugLoc}, q{LLVMRemarkArgRef arg}},
		{q{void}, q{LLVMRemarkEntryDispose}, q{LLVMRemarkEntryRef remark}},
		{q{LLVMRemarkType}, q{LLVMRemarkEntryGetType}, q{LLVMRemarkEntryRef remark}},
		{q{LLVMRemarkStringRef}, q{LLVMRemarkEntryGetPassName}, q{LLVMRemarkEntryRef remark}},
		{q{LLVMRemarkStringRef}, q{LLVMRemarkEntryGetRemarkName}, q{LLVMRemarkEntryRef remark}},
		{q{LLVMRemarkStringRef}, q{LLVMRemarkEntryGetFunctionName}, q{LLVMRemarkEntryRef remark}},
		{q{LLVMRemarkDebugLocRef}, q{LLVMRemarkEntryGetDebugLoc}, q{LLVMRemarkEntryRef remark}},
		{q{ulong}, q{LLVMRemarkEntryGetHotness}, q{LLVMRemarkEntryRef remark}},
		{q{uint}, q{LLVMRemarkEntryGetNumArgs}, q{LLVMRemarkEntryRef remark}},
		{q{LLVMRemarkArgRef}, q{LLVMRemarkEntryGetFirstArg}, q{LLVMRemarkEntryRef remark}},
		{q{LLVMRemarkArgRef}, q{LLVMRemarkEntryGetNextArg}, q{LLVMRemarkArgRef it, LLVMRemarkEntryRef remark}},
		{q{LLVMRemarkParserRef}, q{LLVMRemarkParserCreateYAML}, q{const(void)* buf, ulong size}},
		{q{LLVMRemarkEntryRef}, q{LLVMRemarkParserGetNext}, q{LLVMRemarkParserRef parser}},
		{q{LLVMBool}, q{LLVMRemarkParserHasError}, q{LLVMRemarkParserRef parser}},
		{q{const(char)*}, q{LLVMRemarkParserGetErrorMessage}, q{LLVMRemarkParserRef parser}},
		{q{void}, q{LLVMRemarkParserDispose}, q{LLVMRemarkParserRef parser}},
		{q{uint}, q{LLVMRemarkVersion}, q{}},
	];
	static if(REMARKS_API_VERSION >= 1){
		FnBind[] add = [
			{q{LLVMRemarkParserRef}, q{LLVMRemarkParserCreateBitstream}, q{const(void)* buf, ulong size}},
		];
		ret ~= add;
	}
	return ret;
}()));
