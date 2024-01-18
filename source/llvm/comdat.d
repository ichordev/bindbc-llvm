/+
+            Copyright 2023 – 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http:
+/
module llvm.comdat;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

alias LLVMComdatSelectionKind = int;
enum: LLVMComdatSelectionKind{
	LLVMAnyComdatSelectionKind,
	LLVMExactMatchComdatSelectionKind,
	LLVMLargestComdatSelectionKind,
	LLVMNoDeduplicateComdatSelectionKind,
	LLVMSameSizeComdatSelectionKind,
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMComdatRef}, q{LLVMGetOrInsertComdat}, q{LLVMModuleRef m, const(char)* name}},
		{q{LLVMComdatRef}, q{LLVMGetComdat}, q{LLVMValueRef v}},
		{q{void}, q{LLVMSetComdat}, q{LLVMValueRef v, LLVMComdatRef c}},
		{q{LLVMComdatSelectionKind}, q{LLVMGetComdatSelectionKind}, q{LLVMComdatRef c}},
		{q{void}, q{LLVMSetComdatSelectionKind}, q{LLVMComdatRef c, LLVMComdatSelectionKind kind}},
	];
	return ret;
}()));
