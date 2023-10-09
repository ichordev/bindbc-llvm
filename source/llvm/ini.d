/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.ini;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{LLVMInitializeCore}, q{LLVMPassRegistryRef r}, aliases: [q{LLVMInitialiseCore}]},
		{q{void}, q{LLVMInitializeTransformUtils}, q{LLVMPassRegistryRef r}, aliases: [q{LLVMInitialiseTransformUtils}]},
		{q{void}, q{LLVMInitializeScalarOpts}, q{LLVMPassRegistryRef r}, aliases: [q{LLVMInitialiseScalarOpts}]},
		{q{void}, q{LLVMInitializeVectorization}, q{LLVMPassRegistryRef r}, aliases: [q{LLVMInitialiseVectorisation}]},
		{q{void}, q{LLVMInitializeInstCombine}, q{LLVMPassRegistryRef r}, aliases: [q{LLVMInitialiseInstCombine}]},
		{q{void}, q{LLVMInitializeIPO}, q{LLVMPassRegistryRef r}, aliases: [q{LLVMInitialiseIPO}]},
		{q{void}, q{LLVMInitializeAnalysis}, q{LLVMPassRegistryRef r}, aliases: [q{LLVMInitialiseAnalysis}]},
		{q{void}, q{LLVMInitializeIPA}, q{LLVMPassRegistryRef r}, aliases: [q{LLVMInitialiseIPA}]},
		{q{void}, q{LLVMInitializeCodeGen}, q{LLVMPassRegistryRef r}, aliases: [q{LLVMInitialiseCodeGen}]},
		{q{void}, q{LLVMInitializeTarget}, q{LLVMPassRegistryRef r}, aliases: [q{LLVMInitialiseTarget}]},
	];
	return ret;
}()));
