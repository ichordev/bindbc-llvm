/+
+            Copyright 2023 – 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.errorhandling;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

alias LLVMFatalErrorHandler = extern(C) void function(const(char)* reason) nothrow;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{LLVMInstallFatalErrorHandler}, q{LLVMFatalErrorHandler handler}},
		{q{void}, q{LLVMResetFatalErrorHandler}, q{}},
		{q{void}, q{LLVMEnablePrettyStackTrace}, q{}},
	];
	return ret;
}()));
