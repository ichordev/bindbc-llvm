/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.lljit;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.error;
import llvm.orc;
import llvm.targetmachine;
import llvm.types;

alias LLVMOrcLLJITBuilderObjectLinkingLayerCreatorFunction = extern(C) LLVMOrcObjectLayerRef function(void* ctx, LLVMOrcExecutionSessionRef es, const(char)* triple) nothrow;

struct LLVMOrcOpaqueLLJITBuilder;
alias LLVMOrcLLJITBuilderRef = LLVMOrcOpaqueLLJITBuilder*;

struct LLVMOrcOpaqueLLJIT;
alias LLVMOrcLLJITRef = LLVMOrcOpaqueLLJIT*;

mixin(joinFnBinds((){
    FnBind[] ret = [
        {q{LLVMOrcLLJITBuilderRef}, q{LLVMOrcCreateLLJITBuilder}, q{}},
        {q{void}, q{LLVMOrcDisposeLLJITBuilder}, q{LLVMOrcLLJITBuilderRef builder}},
        {q{void}, q{LLVMOrcLLJITBuilderSetJITTargetMachineBuilder}, q{LLVMOrcLLJITBuilderRef builder, LLVMOrcJITTargetMachineBuilderRef jtmb}},
        {q{void}, q{LLVMOrcLLJITBuilderSetObjectLinkingLayerCreator}, q{LLVMOrcLLJITBuilderRef builder, LLVMOrcLLJITBuilderObjectLinkingLayerCreatorFunction f, void* ctx}},
        {q{LLVMErrorRef}, q{LLVMOrcCreateLLJIT}, q{LLVMOrcLLJITRef* result, LLVMOrcLLJITBuilderRef builder}},
        {q{LLVMErrorRef}, q{LLVMOrcDisposeLLJIT}, q{LLVMOrcLLJITRef j}},
        {q{LLVMOrcExecutionSessionRef}, q{LLVMOrcLLJITGetExecutionSession}, q{LLVMOrcLLJITRef j}},
        {q{LLVMOrcJITDylibRef}, q{LLVMOrcLLJITGetMainJITDylib}, q{LLVMOrcLLJITRef j}},
        {q{const(char)*}, q{LLVMOrcLLJITGetTripleString}, q{LLVMOrcLLJITRef j}},
        {q{char}, q{LLVMOrcLLJITGetGlobalPrefix}, q{LLVMOrcLLJITRef j}},
        {q{LLVMOrcSymbolStringPoolEntryRef}, q{LLVMOrcLLJITMangleAndIntern}, q{LLVMOrcLLJITRef j, const(char)* unmangledName}},
        {q{LLVMErrorRef}, q{LLVMOrcLLJITAddObjectFile}, q{LLVMOrcLLJITRef j, LLVMOrcJITDylibRef jd, LLVMMemoryBufferRef objBuffer}},
        {q{LLVMErrorRef}, q{LLVMOrcLLJITAddObjectFileWithRT}, q{LLVMOrcLLJITRef j, LLVMOrcResourceTrackerRef rt, LLVMMemoryBufferRef objBuffer}},
        {q{LLVMErrorRef}, q{LLVMOrcLLJITAddLLVMIRModule}, q{LLVMOrcLLJITRef j, LLVMOrcJITDylibRef jd, LLVMOrcThreadSafeModuleRef tsm}},
        {q{LLVMErrorRef}, q{LLVMOrcLLJITAddLLVMIRModuleWithRT}, q{LLVMOrcLLJITRef j, LLVMOrcResourceTrackerRef jd, LLVMOrcThreadSafeModuleRef tsm}},
        {q{LLVMErrorRef}, q{LLVMOrcLLJITLookup}, q{LLVMOrcLLJITRef j, LLVMOrcExecutorAddress* result, const(char)* name}},
        {q{LLVMOrcObjectLayerRef}, q{LLVMOrcLLJITGetObjLinkingLayer}, q{LLVMOrcLLJITRef j}},
        {q{LLVMOrcObjectTransformLayerRef}, q{LLVMOrcLLJITGetObjTransformLayer}, q{LLVMOrcLLJITRef j}},
        {q{LLVMOrcIRTransformLayerRef}, q{LLVMOrcLLJITGetIRTransformLayer}, q{LLVMOrcLLJITRef j}},
        {q{const(char)*}, q{LLVMOrcLLJITGetDataLayoutStr}, q{LLVMOrcLLJITRef j}},
    ];
    return ret;
}()));
