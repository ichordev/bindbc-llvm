/+
+            Copyright 2023 – 2024 Aya Partridge
+ Distributed under the Boost Software license, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.transforms.passbuilder;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.error;
import llvm.targetmachine;
import llvm.types;

struct LLVMOpaquePassBuilderOptions;
alias LLVMPassBuilderOptionsRef = LLVMOpaquePassBuilderOptions*;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMErrorRef}, q{LLVMRunPasses}, q{LLVMModuleRef m, const(char)* passes, LLVMTargetMachineRef tm, LLVMPassBuilderOptionsRef options}},
		{q{LLVMPassBuilderOptionsRef}, q{LLVMCreatePassBuilderOptions}, q{}},
		{q{void}, q{LLVMPassBuilderOptionsSetVerifyEach}, q{LLVMPassBuilderOptionsRef options, LLVMBool verifyEach}},
		{q{void}, q{LLVMPassBuilderOptionsSetDebugLogging}, q{LLVMPassBuilderOptionsRef options, LLVMBool debugLogging}},
		{q{void}, q{LLVMPassBuilderOptionsSetLoopInterleaving}, q{LLVMPassBuilderOptionsRef options, LLVMBool loopInterleaving}},
		{q{void}, q{LLVMPassBuilderOptionsSetLoopVectorization}, q{LLVMPassBuilderOptionsRef options, LLVMBool loopVectorisation}, aliases: [q{LLVMPassBuilderOptionsSetLoopVectorisation}]},
		{q{void}, q{LLVMPassBuilderOptionsSetSLPVectorization}, q{LLVMPassBuilderOptionsRef options, LLVMBool slpVectorisation}, aliases: [q{LLVMPassBuilderOptionsSetSLPVectorisation}]},
		{q{void}, q{LLVMPassBuilderOptionsSetLoopUnrolling}, q{LLVMPassBuilderOptionsRef options, LLVMBool loopUnrolling}},
		{q{void}, q{LLVMPassBuilderOptionsSetForgetAllSCEVInLoopUnroll}, q{LLVMPassBuilderOptionsRef options, LLVMBool forgetAllSCEVInLoopUnroll}},
		{q{void}, q{LLVMPassBuilderOptionsSetLicmMssaOptCap}, q{LLVMPassBuilderOptionsRef options, uint licmMssaOptCap}},
		{q{void}, q{LLVMPassBuilderOptionsSetLicmMssaNoAccForPromotionCap}, q{LLVMPassBuilderOptionsRef options, uint licmMssaNoAccForPromotionCap}},
		{q{void}, q{LLVMPassBuilderOptionsSetCallGraphProfile}, q{LLVMPassBuilderOptionsRef options, LLVMBool callGraphProfile}},
		{q{void}, q{LLVMPassBuilderOptionsSetMergeFunctions}, q{LLVMPassBuilderOptionsRef options, LLVMBool mergeFunctions}},
		{q{void}, q{LLVMDisposePassBuilderOptions}, q{LLVMPassBuilderOptionsRef options}},
	];
	return ret;
}()));
