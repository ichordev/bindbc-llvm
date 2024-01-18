/+
+            Copyright 2023 – 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.transforms.passmanagerbuilder;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

struct LLVMOpaquePassManagerBuilder;
alias LLVMPassManagerBuilderRef = LLVMOpaquePassManagerBuilder*;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMPassManagerBuilderRef}, q{LLVMPassManagerBuilderCreate}, q{}},
		{q{void}, q{LLVMPassManagerBuilderDispose}, q{LLVMPassManagerBuilderRef pmb}},
		{q{void}, q{LLVMPassManagerBuilderSetOptLevel}, q{LLVMPassManagerBuilderRef pmb, uint optLevel}},
		{q{void}, q{LLVMPassManagerBuilderSetSizeLevel}, q{LLVMPassManagerBuilderRef pmb, uint sizeLevel}},
		{q{void}, q{LLVMPassManagerBuilderSetDisableUnitAtATime}, q{LLVMPassManagerBuilderRef pmb, LLVMBool value}},
		{q{void}, q{LLVMPassManagerBuilderSetDisableUnrollLoops}, q{LLVMPassManagerBuilderRef pmb, LLVMBool value}},
		{q{void}, q{LLVMPassManagerBuilderSetDisableSimplifyLibCalls}, q{LLVMPassManagerBuilderRef pmb, LLVMBool value}},
		{q{void}, q{LLVMPassManagerBuilderUseInlinerWithThreshold}, q{LLVMPassManagerBuilderRef pmb, uint threshold}},
		{q{void}, q{LLVMPassManagerBuilderPopulateFunctionPassManager}, q{LLVMPassManagerBuilderRef pmb, LLVMPassManagerRef pm}},
		{q{void}, q{LLVMPassManagerBuilderPopulateModulePassManager}, q{LLVMPassManagerBuilderRef pmb, LLVMPassManagerRef pm}},
	];
	return ret;
}()));
