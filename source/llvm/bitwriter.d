/+
+            Copyright 2023 – 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.bitwriter;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{int}, q{LLVMWriteBitcodeToFile}, q{LLVMModuleRef m, const(char)* path}},
		{q{int}, q{LLVMWriteBitcodeToFD}, q{LLVMModuleRef m, int fd, int shouldClose, int unbuffered}},
		{q{int}, q{LLVMWriteBitcodeToFileHandle}, q{LLVMModuleRef m, int handle}},
		{q{LLVMMemoryBufferRef}, q{LLVMWriteBitcodeToMemoryBuffer}, q{LLVMModuleRef m}},
	];
	return ret;
}()));
