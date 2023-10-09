/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.analysis;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

alias LLVMVerifierFailureAction = int;
enum: LLVMVerifierFailureAction{
	LLVMAbortProcessAction,
	LLVMPrintMessageAction,
	LLVMReturnStatusAction,
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMBool}, q{LLVMVerifyModule}, q{LLVMModuleRef m, LLVMVerifierFailureAction action, char** outMessage}},
		{q{LLVMBool}, q{LLVMVerifyFunction}, q{LLVMValueRef fn, LLVMVerifierFailureAction action}},
		{q{void}, q{LLVMViewFunctionCFG}, q{LLVMValueRef fn}},
		{q{void}, q{LLVMViewFunctionCFGOnly}, q{LLVMValueRef fn}},
	];
	return ret;
}()));
