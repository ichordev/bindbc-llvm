/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.transforms.scalar;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{LLVMAddAggressiveDCEPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddDCEPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddBitTrackingDCEPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddAlignmentFromAssumptionsPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddCFGSimplificationPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddDeadStoreEliminationPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddScalarizerPass}, q{LLVMPassManagerRef pm}, aliases: [q{LLVMAddScalariserPass}]},
		{q{void}, q{LLVMAddMergedLoadStoreMotionPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddGVNPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddNewGVNPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddIndVarSimplifyPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddInstructionCombiningPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddInstructionSimplifyPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddJumpThreadingPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddLICMPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddLoopDeletionPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddLoopIdiomPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddLoopRotatePass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddLoopRerollPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddLoopUnrollPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddLoopUnrollAndJamPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddLowerAtomicPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddMemCpyOptPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddPartiallyInlineLibCallsPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddReassociatePass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddSCCPPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddScalarReplAggregatesPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddScalarReplAggregatesPassSSA}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddScalarReplAggregatesPassWithThreshold}, q{LLVMPassManagerRef pm, int threshold}},
		{q{void}, q{LLVMAddSimplifyLibCallsPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddTailCallEliminationPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddDemoteMemoryToRegisterPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddVerifierPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddCorrelatedValuePropagationPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddEarlyCSEPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddEarlyCSEMemSSAPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddLowerExpectIntrinsicPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddLowerConstantIntrinsicsPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddTypeBasedAliasAnalysisPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddScopedNoAliasAAPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddBasicAliasAnalysisPass}, q{LLVMPassManagerRef pm}},
		{q{void}, q{LLVMAddUnifyFunctionExitNodesPass}, q{LLVMPassManagerRef pm}},
	];
	return ret;
}()));
