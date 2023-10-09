/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.error;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

enum LLVMErrorSuccess = 0;

struct LLVMOpaqueError;
alias LLVMErrorRef = LLVMOpaqueError*;

alias LLVMErrorTypeId = const(void)*;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMErrorTypeId}, q{LLVMGetErrorTypeId}, q{LLVMErrorRef Err}},
		{q{void}, q{LLVMConsumeError}, q{LLVMErrorRef Err}},
		{q{char},*q{ LLVMGetErrorMessage}, q{LLVMErrorRef Err}},
		{q{void}, q{LLVMDisposeErrorMessage}, q{char* ErrMsg}},
		{q{LLVMErrorTypeId}, q{LLVMGetStringErrorTypeId}, q{}},
		{q{LLVMErrorRef}, q{LLVMCreateStringError}, q{const(char)* ErrMsg}},
	];
	return ret;
}()));
