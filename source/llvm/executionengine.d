/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.executionengine;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.target;
import llvm.targetmachine;
import llvm.types;

struct LLVMOpaqueGenericValue;
alias LLVMGenericValueRef = LLVMOpaqueGenericValue*;

struct LLVMOpaqueExecutionEngine;
alias LLVMExecutionEngineRef = LLVMOpaqueExecutionEngine*;

struct LLVMOpaqueMCJITMemoryManager;
alias LLVMMCJITMemoryManagerRef = LLVMOpaqueMCJITMemoryManager*;

struct LLVMMCJITCompilerOptions{
	uint optLevel;
	LLVMCodeModel codeModel;
	LLVMBool noFramePointerElim;
	LLVMBool enableFastISel;
	LLVMMCJITMemoryManagerRef mcjmm;
}

extern(C) nothrow{
	alias LLVMMemoryManagerAllocateCodeSectionCallback = ubyte* function(void* opaque, size_t size, uint alignment, uint sectionID, const(char)* sectionName);
	alias LLVMMemoryManagerAllocateDataSectionCallback = ubyte* function(void* opaque, size_t size, uint alignment, uint sectionID, const(char)* sectionName, LLVMBool isReadOnly);
	alias LLVMMemoryManagerFinalizeMemoryCallback = LLVMBool function(void* opaque, char** errMsg);
	alias LLVMMemoryManagerFinaliseMemoryCallback = LLVMMemoryManagerFinalizeMemoryCallback;
	alias LLVMMemoryManagerDestroyCallback = void function(void* opaque);
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{LLVMLinkInMCJIT}, q{}},
		{q{void}, q{LLVMLinkInInterpreter}, q{}},
		{q{LLVMGenericValueRef}, q{LLVMCreateGenericValueOfInt}, q{LLVMTypeRef ty, ulong n, LLVMBool isSigned}},
		{q{LLVMGenericValueRef}, q{LLVMCreateGenericValueOfPointer}, q{void* p}},
		{q{LLVMGenericValueRef}, q{LLVMCreateGenericValueOfFloat}, q{LLVMTypeRef ty, double n}},
		{q{uint}, q{LLVMGenericValueIntWidth}, q{LLVMGenericValueRef genValRef}},
		{q{ulong}, q{LLVMGenericValueToInt}, q{LLVMGenericValueRef genVal, LLVMBool isSigned}},
		{q{void*}, q{LLVMGenericValueToPointer}, q{LLVMGenericValueRef genVal}},
		{q{double}, q{LLVMGenericValueToFloat}, q{LLVMTypeRef tyRef, LLVMGenericValueRef genVal}},
		{q{void}, q{LLVMDisposeGenericValue}, q{LLVMGenericValueRef genVal}},
		{q{LLVMBool}, q{LLVMCreateExecutionEngineForModule}, q{LLVMExecutionEngineRef* outEE, LLVMModuleRef m, char** outError}},
		{q{LLVMBool}, q{LLVMCreateInterpreterForModule}, q{LLVMExecutionEngineRef* outInterp, LLVMModuleRef m, char** outError}},
		{q{LLVMBool}, q{LLVMCreateJITCompilerForModule}, q{LLVMExecutionEngineRef* outJIT, LLVMModuleRef m, uint optLevel, char** outError}},
		{q{void}, q{LLVMInitializeMCJITCompilerOptions}, q{LLVMMCJITCompilerOptions* options, size_t sizeOfOptions}, aliases: [q{LLVMInitialiseMCJITCompilerOptions}]},
		{q{LLVMBool}, q{LLVMCreateMCJITCompilerForModule}, q{LLVMExecutionEngineRef* outJIT, LLVMModuleRef m, LLVMMCJITCompilerOptions* options, size_t sizeOfOptions, char** outError}},
		{q{void}, q{LLVMDisposeExecutionEngine}, q{LLVMExecutionEngineRef ee}},
		{q{void}, q{LLVMRunStaticConstructors}, q{LLVMExecutionEngineRef ee}},
		{q{void}, q{LLVMRunStaticDestructors}, q{LLVMExecutionEngineRef ee}},
		{q{int}, q{LLVMRunFunctionAsMain}, q{LLVMExecutionEngineRef ee, LLVMValueRef f, uint argC, const(char*)* argV, const(char*)* envP}},
		{q{LLVMGenericValueRef}, q{LLVMRunFunction}, q{LLVMExecutionEngineRef ee, LLVMValueRef f, uint numArgs, LLVMGenericValueRef* args}},
		{q{void}, q{LLVMFreeMachineCodeForFunction}, q{LLVMExecutionEngineRef ee, LLVMValueRef f}},
		{q{void}, q{LLVMAddModule}, q{LLVMExecutionEngineRef ee, LLVMModuleRef m}},
		{q{LLVMBool}, q{LLVMRemoveModule}, q{LLVMExecutionEngineRef ee, LLVMModuleRef m, LLVMModuleRef* outMod, char** outError}},
		{q{LLVMBool}, q{LLVMFindFunction}, q{LLVMExecutionEngineRef ee, const(char)* name, LLVMValueRef* outFn}},
		{q{void*}, q{LLVMRecompileAndRelinkFunction}, q{LLVMExecutionEngineRef ee, LLVMValueRef fn}},
		{q{LLVMTargetDataRef}, q{LLVMGetExecutionEngineTargetData}, q{LLVMExecutionEngineRef ee}},
		{q{LLVMTargetMachineRef}, q{LLVMGetExecutionEngineTargetMachine}, q{LLVMExecutionEngineRef ee}},
		{q{void}, q{LLVMAddGlobalMapping}, q{LLVMExecutionEngineRef ee, LLVMValueRef global, void* addr}},
		{q{void*}, q{LLVMGetPointerToGlobal}, q{LLVMExecutionEngineRef ee, LLVMValueRef global}},
		{q{ulong}, q{LLVMGetGlobalValueAddress}, q{LLVMExecutionEngineRef ee, const(char)* name}},
		{q{ulong}, q{LLVMGetFunctionAddress}, q{LLVMExecutionEngineRef ee, const(char)* name}},
		{q{LLVMBool}, q{LLVMExecutionEngineGetErrMsg}, q{LLVMExecutionEngineRef ee, char** outError}},
		{q{LLVMMCJITMemoryManagerRef}, q{LLVMCreateSimpleMCJITMemoryManager}, q{void* opaque, LLVMMemoryManagerAllocateCodeSectionCallback allocateCodeSection, LLVMMemoryManagerAllocateDataSectionCallback allocateDataSection, LLVMMemoryManagerFinalizeMemoryCallback finaliseMemory, LLVMMemoryManagerDestroyCallback destroy}},
		{q{void}, q{LLVMDisposeMCJITMemoryManager}, q{LLVMMCJITMemoryManagerRef mm}},
		{q{LLVMJITEventListenerRef}, q{LLVMCreateGDBRegistrationListener}, q{}},
		{q{LLVMJITEventListenerRef}, q{LLVMCreateIntelJITEventListener}, q{}},
		{q{LLVMJITEventListenerRef}, q{LLVMCreateOProfileJITEventListener}, q{}},
		{q{LLVMJITEventListenerRef}, q{LLVMCreatePerfJITEventListener}, q{}},
	];
	return ret;
}()));
