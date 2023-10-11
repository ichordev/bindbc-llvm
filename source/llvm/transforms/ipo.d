/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.transforms.ipo;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

alias MustPreserve = extern(C) LLVMBool function(LLVMValueRef, void*) nothrow;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{LLVMAddConstantMergePass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddMergeFunctionsPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddCalledValuePropagationPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddDeadArgEliminationPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddFunctionAttrsPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddFunctionInliningPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddAlwaysInlinerPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddGlobalDCEPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddGlobalOptimizerPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddIPSCCPPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddInternalizePass}, q{LLVMPassManagerRef, uint allButMain}},
		{q{void}, q{LLVMAddInternalizePassWithMustPreservePredicate}, q{LLVMPassManagerRef pm, void* context, MustPreserve mustPreserve}},
		{q{void}, q{LLVMAddStripDeadPrototypesPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddStripSymbolsPass}, q{LLVMPassManagerRef pm}},
	];
	return ret;
}()));
