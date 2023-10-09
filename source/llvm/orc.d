/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.orc;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.error;
import llvm.targetmachine;
import llvm.types;

alias LLVMOrcJITTargetAddress = ulong;

alias LLVMOrcExecutorAddress = ulong;

alias LLVMJITSymbolGenericFlags = uint;
enum: LLVMJITSymbolGenericFlags{
	LLVMJITSymbolGenericFlagsNone                              = 0,
	LLVMJITSymbolGenericFlagsExported                          = 1U << 0,
	LLVMJITSymbolGenericFlagsWeak                              = 1U << 1,
	LLVMJITSymbolGenericFlagsCallable                          = 1U << 2,
	LLVMJITSymbolGenericFlagsMaterializationSideEffectsOnly    = 1U << 3, 
}

alias LLVMJITSymbolTargetFlags = ubyte;

struct LLVMJITSymbolFlags{
	ubyte genericFlags;
	ubyte targetFlags;
}

struct LLVMJITEvaluatedSymbol{
	LLVMOrcExecutorAddress address;
	LLVMJITSymbolFlags flags;
}

struct LLVMOrcOpaqueExecutionSession;
alias LLVMOrcExecutionSessionRef = LLVMOrcOpaqueExecutionSession*;

alias LLVMOrcErrorReporterFunction = void function(void* ctx, LLVMErrorRef err);

struct LLVMOrcOpaqueSymbolStringPool;
alias LLVMOrcSymbolStringPoolRef = LLVMOrcOpaqueSymbolStringPool*;

struct LLVMOrcOpaqueSymbolStringPoolEntry;
alias LLVMOrcSymbolStringPoolEntryRef = LLVMOrcOpaqueSymbolStringPoolEntry*;

struct LLVMOrcCSymbolFlagsMapPair{
	LLVMOrcSymbolStringPoolEntryRef name;
	LLVMJITSymbolFlags flags;
}

alias LLVMOrcCSymbolFlagsMapPairs = LLVMOrcCSymbolFlagsMapPair*;

struct LLVMOrcCSymbolMapPair{
	LLVMOrcSymbolStringPoolEntryRef name;
	LLVMJITEvaluatedSymbol sym;
}

alias LLVMOrcCSymbolMapPairs = LLVMOrcCSymbolMapPair*;

struct LLVMOrcCSymbolAliasMapEntry{
	LLVMOrcSymbolStringPoolEntryRef name;
	LLVMJITSymbolFlags flags;
}

struct LLVMOrcCSymbolAliasMapPair{
	LLVMOrcSymbolStringPoolEntryRef name;
	LLVMOrcCSymbolAliasMapEntry entry;
}

alias LLVMOrcCSymbolAliasMapPairs = LLVMOrcCSymbolAliasMapPair*;

struct LLVMOrcOpaqueJITDylib;
alias LLVMOrcJITDylibRef = LLVMOrcOpaqueJITDylib*;

struct LLVMOrcCSymbolsList{
	LLVMOrcSymbolStringPoolEntryRef* symbols;
	size_t length;
}

struct LLVMOrcCDependenceMapPair{
	LLVMOrcJITDylibRef jd;
	LLVMOrcCSymbolsList names;
}

alias LLVMOrcCDependenceMapPairs = LLVMOrcCDependenceMapPair*;

alias LLVMOrcLookupKind = int;
enum: LLVMOrcLookupKind{
	LLVMOrcLookupKindStatic,
	LLVMOrcLookupKindDLSym, 
}

alias LLVMOrcJITDylibLookupFlags = int;
enum: LLVMOrcJITDylibLookupFlags{
	LLVMOrcJITDylibLookupFlagsMatchExportedSymbolsOnly,
	LLVMOrcJITDylibLookupFlagsMatchAllSymbols, 
}

struct LLVMOrcCJITDylibSearchOrderElement{
	LLVMOrcJITDylibRef jd;
	LLVMOrcJITDylibLookupFlags jdLookupFlags;
}

alias LLVMOrcCJITDylibSearchOrder = LLVMOrcCJITDylibSearchOrderElement*;

alias LLVMOrcSymbolLookupFlags = int;
enum: LLVMOrcSymbolLookupFlags{
	LLVMOrcSymbolLookupFlagsRequiredSymbol,
	LLVMOrcSymbolLookupFlagsWeaklyReferencedSymbol, 
}

struct LLVMOrcCLookupSetElement{
	LLVMOrcSymbolStringPoolEntryRef name;
	LLVMOrcSymbolLookupFlags lookupFlags;
}

alias LLVMOrcCLookupSet = LLVMOrcCLookupSetElement*;

struct LLVMOrcOpaqueMaterializationUnit;
alias LLVMOrcOpaqueMaterialisationUnit = LLVMOrcOpaqueMaterializationUnit;
alias LLVMOrcMaterializationUnitRef = LLVMOrcOpaqueMaterializationUnit*;
alias LLVMOrcMaterialisationUnitRef = LLVMOrcMaterializationUnitRef;

struct LLVMOrcOpaqueMaterializationResponsibility;
alias LLVMOrcOpaqueMaterialisationResponsibility = LLVMOrcOpaqueMaterializationResponsibility;
alias LVMOrcMaterializationResponsibilityRef = LLVMOrcOpaqueMaterializationResponsibility*;
alias LVMOrcMaterialisationResponsibilityRef = LVMOrcMaterializationResponsibilityRef;

alias LLVMOrcMaterializationUnitMaterializeFunction = extern(C) void function(void* ctx, LLVMOrcMaterializationResponsibilityRef mr) nothrow;
alias LLVMOrcMaterialisationUnitMaterializeFunction = LLVMOrcMaterializationUnitMaterializeFunction;

alias LLVMOrcMaterializationUnitDiscardFunction = extern(C) void function(void* ctx, LLVMOrcJITDylibRef jd, LLVMOrcSymbolStringPoolEntryRef symbol) nothrow;
alias LLVMOrcMaterialisationUnitDiscardFunction = LLVMOrcMaterializationUnitDiscardFunction;

alias LLVMOrcMaterializationUnitDestroyFunction = extern(C) void function(void* ctx) nothrow;
alias LLVMOrcMaterialisationUnitDestroyFunction = LLVMOrcMaterializationUnitDestroyFunction;

struct LLVMOrcOpaqueResourceTracker;
alias LLVMOrcResourceTrackerRef = LLVMOrcOpaqueResourceTracker*;

struct LLVMOrcOpaqueDefinitionGenerator;
alias LVMOrcDefinitionGeneratorRef = LLVMOrcOpaqueDefinitionGenerator*;

struct LLVMOrcOpaqueLookupState;
alias LLVMOrcLookupStateRef = LLVMOrcOpaqueLookupState*;

alias LLVMOrcCAPIDefinitionGeneratorTryToGenerateFunction = extern(C) LLVMErrorRef function(LLVMOrcDefinitionGeneratorRef generatorObj, void* ctx, LLVMOrcLookupStateRef* lookupState, LLVMOrcLookupKind kind, LLVMOrcJITDylibRef jd, LLVMOrcJITDylibLookupFlags jdLookupFlags, LLVMOrcCLookupSet lookupSet, size_t lookupSetSize) nothrow;

alias LLVMOrcDisposeCAPIDefinitionGeneratorFunction = extern(C) void function(void* ctx) nothrow;

alias LLVMOrcSymbolPredicate = extern(C) int function(void* Ctx, LLVMOrcSymbolStringPoolEntryRef sym) nothrow;

struct LLVMOrcOpaqueThreadSafeContext;
alias LLVMOrcThreadSafeContextRef = LLVMOrcOpaqueThreadSafeContext*;

struct LLVMOrcOpaqueThreadSafeModule;
alias LLVMOrcThreadSafeModuleRef = LLVMOrcOpaqueThreadSafeModule*;

alias LLVMOrcGenericIRModuleOperationFunction = extern(C) LLVMErrorRef function(void* ctx, LLVMModuleRef m) nothrow;

struct LLVMOrcOpaqueJITTargetMachineBuilder;
alias LVMOrcJITTargetMachineBuilderRef = LLVMOrcOpaqueJITTargetMachineBuilder*;

struct LLVMOrcOpaqueObjectLayer;
alias LLVMOrcObjectLayerRef = LLVMOrcOpaqueObjectLayer*;

struct LLVMOrcOpaqueObjectLinkingLayer;
alias LLVMOrcObjectLinkingLayerRef = LLVMOrcOpaqueObjectLinkingLayer*;

struct LLVMOrcOpaqueIRTransformLayer;
alias LLVMOrcIRTransformLayerRef = LLVMOrcOpaqueIRTransformLayer*;

alias LLVMOrcObjectTransformLayerTransformFunction = extern(C) LLVMErrorRef function(void* ctx, LLVMMemoryBufferRef* objInOut) nothrow;

struct LLVMOrcOpaqueIndirectStubsManager;
alias LVMOrcIndirectStubsManagerRef = LLVMOrcOpaqueIndirectStubsManager*;

struct LLVMOrcOpaqueLazyCallThroughManager;
alias LVMOrcLazyCallThroughManagerRef = LLVMOrcOpaqueLazyCallThroughManager*;

struct LLVMOrcOpaqueDumpObjects;
alias LLVMOrcDumpObjectsRef = LLVMOrcOpaqueDumpObjects*;

alias LLVMOrcExecutionSessionLookupHandleResultFunction = extern(C) void function(LLVMErrorRef err, LLVMOrcCSymbolMapPairs result, size_t numPairs, void* ctx) nothrow;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{LLVMOrcExecutionSessionSetErrorReporter}, q{LLVMOrcExecutionSessionRef es, LLVMOrcErrorReporterFunction reportError, void* ctx}},
		{q{LLVMOrcSymbolStringPoolRef}, q{LLVMOrcExecutionSessionGetSymbolStringPool}, q{LLVMOrcExecutionSessionRef es}},
		{q{void}, q{LLVMOrcSymbolStringPoolClearDeadEntries}, q{LLVMOrcSymbolStringPoolRef ssp}},
		{q{LLVMOrcSymbolStringPoolEntryRef}, q{LLVMOrcExecutionSessionIntern}, q{LLVMOrcExecutionSessionRef es, const(char)* name}},
		{q{void}, q{LLVMOrcExecutionSessionLookup}, q{LLVMOrcExecutionSessionRef es, LLVMOrcLookupKind k, LLVMOrcCJITDylibSearchOrder searchOrder, size_t searchOrderSize, LLVMOrcCLookupSet symbols, size_t symbolsSize, LLVMOrcExecutionSessionLookupHandleResultFunction handleResult, void* ctx}},
		{q{void}, q{LLVMOrcRetainSymbolStringPoolEntry}, q{LLVMOrcSymbolStringPoolEntryRef s}},
		{q{void}, q{LLVMOrcReleaseSymbolStringPoolEntry}, q{LLVMOrcSymbolStringPoolEntryRef s}},
		{q{const(char)*}, q{LLVMOrcSymbolStringPoolEntryStr}, q{LLVMOrcSymbolStringPoolEntryRef s}},
		{q{void}, q{LLVMOrcReleaseResourceTracker}, q{LLVMOrcResourceTrackerRef rt}},
		{q{void}, q{LLVMOrcResourceTrackerTransferTo}, q{LLVMOrcResourceTrackerRef srcRT, LLVMOrcResourceTrackerRef dstRT}},
		{q{LLVMErrorRef}, q{LLVMOrcResourceTrackerRemove}, q{LLVMOrcResourceTrackerRef rt}},
		{q{void}, q{LLVMOrcDisposeDefinitionGenerator}, q{LLVMOrcDefinitionGeneratorRef dg}},
		{q{void}, q{LLVMOrcDisposeMaterializationUnit}, q{LLVMOrcMaterializationUnitRef mu}, aliases: [q{LLVMOrcDisposeMaterialisationUnit}]},
		{q{LLVMOrcMaterializationUnitRef}, q{LLVMOrcCreateCustomMaterializationUnit}, q{const(char)* name, void* ctx, LLVMOrcCSymbolFlagsMapPairs syms, size_t numSyms, LLVMOrcSymbolStringPoolEntryRef initSym, LLVMOrcMaterializationUnitMaterializeFunction materialize, LLVMOrcMaterializationUnitDiscardFunction discard, LLVMOrcMaterializationUnitDestroyFunction destroy}, aliases: [q{LLVMOrcMaterialisationUnitRef}]},
		{q{LLVMOrcMaterializationUnitRef}, q{LLVMOrcAbsoluteSymbols}, q{LLVMOrcCSymbolMapPairs syms, size_t numPairs}, aliases: [q{LLVMOrcMaterialisationUnitRef}]},
		{q{LLVMOrcMaterializationUnitRef}, q{LLVMOrcLazyReexports}, q{LLVMOrcLazyCallThroughManagerRef lctm, LLVMOrcIndirectStubsManagerRef ism, LLVMOrcJITDylibRef sourceRef, LLVMOrcCSymbolAliasMapPairs callableAliases, size_t numPairs}, aliases: [q{LLVMOrcMaterialisationUnitRef}]},
		{q{void}, q{LLVMOrcDisposeMaterializationResponsibility}, q{LLVMOrcMaterializationResponsibilityRef mr}, aliases: [q{LLVMOrcDisposeMaterialisationResponsibility}]},
		{q{LLVMOrcJITDylibRef}, q{LLVMOrcMaterializationResponsibilityGetTargetDylib}, q{LLVMOrcMaterializationResponsibilityRef mr}, aliases: [q{LLVMOrcMaterialisationResponsibilityGetTargetDylib}]},
		{q{LLVMOrcExecutionSessionRef}, q{LLVMOrcMaterializationResponsibilityGetExecutionSession}, q{LLVMOrcMaterializationResponsibilityRef mr}, aliases: [q{LLVMOrcMaterialisationResponsibilityGetExecutionSession}]},
		{q{LLVMOrcCSymbolFlagsMapPairs}, q{LLVMOrcMaterializationResponsibilityGetSymbols}, q{LLVMOrcMaterializationResponsibilityRef mr, size_t* numPairs}, aliases: [q{LLVMOrcMaterialisationResponsibilityGetSymbols}]},
		{q{void}, q{LLVMOrcDisposeCSymbolFlagsMap}, q{LLVMOrcCSymbolFlagsMapPairs pairs}},
		{q{LLVMOrcSymbolStringPoolEntryRef}, q{LLVMOrcMaterializationResponsibilityGetInitializerSymbol}, q{LLVMOrcMaterializationResponsibilityRef mr}, aliases: [q{LLVMOrcMaterialisationResponsibilityGetInitializerSymbol}]},
		{q{LLVMOrcSymbolStringPoolEntryRef*}, q{LLVMOrcMaterializationResponsibilityGetRequestedSymbols}, q{LLVMOrcMaterializationResponsibilityRef mr, size_t* numSymbols}, aliases: [q{LLVMOrcMaterialisationResponsibilityGetRequestedSymbols}]},
		{q{void}, q{LLVMOrcDisposeSymbols}, q{LLVMOrcSymbolStringPoolEntryRef* symbols}},
		{q{LLVMErrorRef}, q{LLVMOrcMaterializationResponsibilityNotifyResolved}, q{LLVMOrcMaterializationResponsibilityRef mr, LLVMOrcCSymbolMapPairs symbols, size_t numPairs}, aliases: [q{LLVMOrcMaterialisationResponsibilityNotifyResolved}]},
		{q{LLVMErrorRef}, q{LLVMOrcMaterializationResponsibilityNotifyEmitted}, q{LLVMOrcMaterializationResponsibilityRef mr}, aliases: [q{LLVMOrcMaterialisationResponsibilityNotifyEmitted}]},
		{q{LLVMErrorRef}, q{LLVMOrcMaterializationResponsibilityDefineMaterializing}, q{LLVMOrcMaterializationResponsibilityRef mr, LLVMOrcCSymbolFlagsMapPairs pairs, size_t numPairs}, aliases: [q{LLVMOrcMaterialisationResponsibilityDefineMaterialising}]},
		{q{void}, q{LLVMOrcMaterializationResponsibilityFailMaterialization}, q{LLVMOrcMaterializationResponsibilityRef mr}, aliases: [q{LLVMOrcMaterialisationResponsibilityFailMaterialisation}]},
		{q{LLVMErrorRef}, q{LLVMOrcMaterializationResponsibilityReplace}, q{LLVMOrcMaterializationResponsibilityRef mr, LLVMOrcMaterializationUnitRef mu}, aliases: [q{LLVMOrcMaterialisationResponsibilityReplace}]},
		{q{LLVMErrorRef}, q{LLVMOrcMaterializationResponsibilityDelegate}, q{LLVMOrcMaterializationResponsibilityRef mr, LLVMOrcSymbolStringPoolEntryRef* symbols, size_t numSymbols, LLVMOrcMaterializationResponsibilityRef* result}, aliases: [q{LLVMOrcMaterialisationResponsibilityDelegate}]},
		{q{void}, q{LLVMOrcMaterializationResponsibilityAddDependencies}, q{LLVMOrcMaterializationResponsibilityRef mr, LLVMOrcSymbolStringPoolEntryRef name, LLVMOrcCDependenceMapPairs dependencies, size_t numPairs}, aliases: [q{LLVMOrcMaterialisationResponsibilityAddDependencies}]},
		{q{void}, q{LLVMOrcMaterializationResponsibilityAddDependenciesForAll}, q{LLVMOrcMaterializationResponsibilityRef mr, LLVMOrcCDependenceMapPairs dependencies, size_t numPairs}, aliases: [q{LLVMOrcMaterialisationResponsibilityAddDependenciesForAll}]},
		{q{LLVMOrcJITDylibRef}, q{LLVMOrcExecutionSessionCreateBareJITDylib}, q{LLVMOrcExecutionSessionRef es, const(char)* name}},
		{q{LLVMErrorRef}, q{LLVMOrcExecutionSessionCreateJITDylib}, q{LLVMOrcExecutionSessionRef es, LLVMOrcJITDylibRef* result, const(char)* name}},
		{q{LLVMOrcJITDylibRef}, q{LLVMOrcExecutionSessionGetJITDylibByName}, q{LLVMOrcExecutionSessionRef es, const(char)* name}},
		{q{LLVMOrcResourceTrackerRef}, q{LLVMOrcJITDylibCreateResourceTracker}, q{LLVMOrcJITDylibRef jd}},
		{q{LLVMOrcResourceTrackerRef}, q{LLVMOrcJITDylibGetDefaultResourceTracker}, q{LLVMOrcJITDylibRef jd}},
		{q{LLVMErrorRef}, q{LLVMOrcJITDylibDefine}, q{LLVMOrcJITDylibRef jd, LLVMOrcMaterializationUnitRef mu}},
		{q{LLVMErrorRef}, q{LLVMOrcJITDylibClear}, q{LLVMOrcJITDylibRef jd}},
		{q{void}, q{LLVMOrcJITDylibAddGenerator}, q{LLVMOrcJITDylibRef jd, LLVMOrcDefinitionGeneratorRef dg}},
		{q{LLVMOrcDefinitionGeneratorRef}, q{LLVMOrcCreateCustomCAPIDefinitionGenerator}, q{LLVMOrcCAPIDefinitionGeneratorTryToGenerateFunction f, void* ctx, LLVMOrcDisposeCAPIDefinitionGeneratorFunction dispose}},
		{q{void}, q{LLVMOrcLookupStateContinueLookup}, q{LLVMOrcLookupStateRef s, LLVMErrorRef err}},
		{q{LLVMErrorRef}, q{LLVMOrcCreateDynamicLibrarySearchGeneratorForProcess}, q{LLVMOrcDefinitionGeneratorRef* result, char globalPrefx, LLVMOrcSymbolPredicate filter, void* filterCtx}},
		{q{LLVMErrorRef}, q{LLVMOrcCreateDynamicLibrarySearchGeneratorForPath}, q{LLVMOrcDefinitionGeneratorRef* result, const(char)* fileName, char globalPrefix, LLVMOrcSymbolPredicate filter, void* filterCtx}},
		{q{LLVMErrorRef}, q{LLVMOrcCreateStaticLibrarySearchGeneratorForPath}, q{LLVMOrcDefinitionGeneratorRef* result, LLVMOrcObjectLayerRef objLayer, const(char)* fileName, const(char)* targetTriple}},
		{q{LLVMOrcThreadSafeContextRef}, q{LLVMOrcCreateNewThreadSafeContext}, q{}},
		{q{LLVMContextRef}, q{LLVMOrcThreadSafeContextGetContext}, q{LLVMOrcThreadSafeContextRef tsCtx}},
		{q{void}, q{LLVMOrcDisposeThreadSafeContext}, q{LLVMOrcThreadSafeContextRef tsCtx}},
		{q{LLVMOrcThreadSafeModuleRef}, q{LLVMOrcCreateNewThreadSafeModule}, q{LLVMModuleRef m, LLVMOrcThreadSafeContextRef tsCtx}},
		{q{void}, q{LLVMOrcDisposeThreadSafeModule}, q{LLVMOrcThreadSafeModuleRef tsm}},
		{q{LLVMErrorRef}, q{LLVMOrcThreadSafeModuleWithModuleDo}, q{LLVMOrcThreadSafeModuleRef tsm, LLVMOrcGenericIRModuleOperationFunction f, void* ctx}},
		{q{LLVMErrorRef}, q{LLVMOrcJITTargetMachineBuilderDetectHost}, q{LLVMOrcJITTargetMachineBuilderRef* result}},
		{q{LLVMOrcJITTargetMachineBuilderRef}, q{LLVMOrcJITTargetMachineBuilderCreateFromTargetMachine}, q{LLVMTargetMachineRef tm}},
		{q{void}, q{LLVMOrcDisposeJITTargetMachineBuilder}, q{LLVMOrcJITTargetMachineBuilderRef jtmb}},
		{q{char*}, q{LLVMOrcJITTargetMachineBuilderGetTargetTriple}, q{LLVMOrcJITTargetMachineBuilderRef jtmb}},
		{q{void}, q{LLVMOrcJITTargetMachineBuilderSetTargetTriple}, q{LLVMOrcJITTargetMachineBuilderRef jtmb, const(char)* targetTriple}},
		{q{LLVMErrorRef}, q{LLVMOrcObjectLayerAddObjectFile}, q{LLVMOrcObjectLayerRef objLayer, LLVMOrcJITDylibRef jd, LLVMMemoryBufferRef objBuffer}},
		{q{LLVMErrorRef}, q{LLVMOrcObjectLayerAddObjectFileWithRT}, q{LLVMOrcObjectLayerRef objLayer, LLVMOrcResourceTrackerRef rt, LLVMMemoryBufferRef objBuffer}},
		{q{void}, q{LLVMOrcObjectLayerEmit}, q{LLVMOrcObjectLayerRef objLayer, LLVMOrcMaterializationResponsibilityRef r, LLVMMemoryBufferRef objBuffer}},
		{q{void}, q{LLVMOrcDisposeObjectLayer}, q{LLVMOrcObjectLayerRef objLayer}},
		{q{void}, q{LLVMOrcIRTransformLayerEmit}, q{LLVMOrcIRTransformLayerRef irTransformLayer, LLVMOrcMaterializationResponsibilityRef mr, LLVMOrcThreadSafeModuleRef tsm}},
		{q{void}, q{LLVMOrcIRTransformLayerSetTransform}, q{LLVMOrcIRTransformLayerRef irTransformLayer, LLVMOrcIRTransformLayerTransformFunction transformFunction, void* ctx}},
		{q{void}, q{LLVMOrcObjectTransformLayerSetTransform}, q{LLVMOrcObjectTransformLayerRef objTransformLayer, LLVMOrcObjectTransformLayerTransformFunction transformFunction, void* ctx}},
		{q{LLVMOrcIndirectStubsManagerRef}, q{LLVMOrcCreateLocalIndirectStubsManager}, q{const(char)* targetTriple}},
		{q{void}, q{LLVMOrcDisposeIndirectStubsManager}, q{LLVMOrcIndirectStubsManagerRef ism}},
		{q{LLVMErrorRef}, q{LLVMOrcCreateLocalLazyCallThroughManager}, q{const(char)* targetTriple, LLVMOrcExecutionSessionRef es, LLVMOrcJITTargetAddress errorHandlerAddr, LLVMOrcLazyCallThroughManagerRef* lctm}},
		{q{void}, q{LLVMOrcDisposeLazyCallThroughManager}, q{LLVMOrcLazyCallThroughManagerRef lctm}},
		{q{LLVMOrcDumpObjectsRef}, q{LLVMOrcCreateDumpObjects}, q{const(char)* dumpDir, const(char)* identifierOverride}},
		{q{void}, q{LLVMOrcDisposeDumpObjects}, q{LLVMOrcDumpObjectsRef dumpObjects}},
		{q{LLVMErrorRef}, q{LLVMOrcDumpObjects_CallOperator}, q{LLVMOrcDumpObjectsRef dumpObjects, LLVMMemoryBufferRef* objBuffer}},
	];
	return ret;
}()));
