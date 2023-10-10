/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.support;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMBool}, q{LLVMLoadLibraryPermanently}, q{const(char)* filename}},
		{q{void}, q{LLVMParseCommandLineOptions}, q{int argc, const(char*)* argv, const(char)* overview}},
		{q{void*}, q{LLVMSearchForAddressOfSymbol}, q{const(char)* symbolName}},
		{q{void}, q{LLVMAddSymbol}, q{const(char)* symbolName, void* symbolValue}},
	];
	return ret;
}()));
