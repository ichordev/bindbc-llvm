/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.linker;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

alias LLVMLinkerMode = int;
enum: LLVMLinkerMode{
	LLVMLinkerDestroySource = 0,
	LLVMLinkerPreserveSource_Removed = 1,
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMBool}, q{LLVMLinkModules2}, q{LLVMModuleRef dest, LLVMModuleRef src}},
	];
	return ret;
}()));
