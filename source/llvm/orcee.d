/+
+            Copyright 2023 – 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.orcee;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.error;
import llvm.executionengine;
import llvm.orc;
import llvm.targetmachine;
import llvm.types;

extern(C) nothrow{
	alias LLVMMemoryManagerCreateContextCallback = void* function(void* ctxCtx);
	alias LLVMMemoryManagerNotifyTerminatingCallback = void function(void* ctxCtx);
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMOrcObjectLayerRef}, q{LLVMOrcCreateRTDyldObjectLinkingLayerWithSectionMemoryManager}, q{LLVMOrcExecutionSessionRef es}},
		{q{LLVMOrcObjectLayerRef}, q{LLVMOrcCreateRTDyldObjectLinkingLayerWithMCJITMemoryManagerLikeCallbacks}, q{LLVMOrcExecutionSessionRef es, void* createContextCtx, LLVMMemoryManagerCreateContextCallback createContext, LLVMMemoryManagerNotifyTerminatingCallback notifyTerminating, LLVMMemoryManagerAllocateCodeSectionCallback allocateCodeSection, LLVMMemoryManagerAllocateDataSectionCallback allocateDataSection, LLVMMemoryManagerFinalizeMemoryCallback finaliseMemory, LLVMMemoryManagerDestroyCallback destroy}},
		{q{void}, q{LLVMOrcRTDyldObjectLinkingLayerRegisterJITEventListener}, q{LLVMOrcObjectLayerRef rtDyldObjLinkingLayer, LLVMJITEventListenerRef listener}},
	];
	return ret;
}()));
