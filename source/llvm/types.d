/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.types;

alias LLVMBool = int;

struct LLVMOpaqueMemoryBuffer;
alias LLVMMemoryBufferRef = LLVMOpaqueMemoryBuffer;

struct LLVMOpaqueContext;
alias LLVMContextRef = LLVMOpaqueContext*;

struct LLVMOpaqueModule;
alias LLVMModuleRef = LLVMOpaqueModule*;

struct LLVMOpaqueType;
alias LLVMTypeRef = LLVMOpaqueType*;

struct LLVMOpaqueValue;
alias LLVMValueRef = LLVMOpaqueValue*;

struct LLVMOpaqueBasicBlock;
alias LLVMBasicBlockRef = LLVMOpaqueBasicBlock*;

struct LLVMOpaqueMetadata;
alias LLVMMetadataRef = LLVMOpaqueMetadata*;

struct LLVMOpaqueNamedMDNode;
alias LLVMNamedMDNodeRef = LLVMOpaqueNamedMDNode*;

struct LLVMValueMetadataEntry;

struct LLVMOpaqueBuilder;
alias LLVMBuilderRef = LLVMOpaqueBuilder*;

struct LLVMOpaqueDIBuilder;
alias LLVMDIBuilderRef = LLVMOpaqueDIBuilder*;

struct LLVMOpaqueModuleProvider;
alias LLVMModuleProviderRef = LLVMOpaqueModuleProvider*;

struct LLVMOpaquePassManager;
alias LLVMPassManagerRef = LLVMOpaquePassManager*;

struct LLVMOpaquePassRegistry;
alias LLVMPassRegistryRef = LLVMOpaquePassRegistry*;

struct LLVMOpaqueUse;
alias LLVMUseRef = LLVMOpaqueUse*;

struct LLVMOpaqueAttributeRef;
alias LLVMAttributeRef = LLVMOpaqueAttributeRef*;

struct LLVMOpaqueDiagnosticInfo;
alias LLVMDiagnosticInfoRef = LLVMOpaqueDiagnosticInfo*;

struct LLVMComdat;
alias LLVMComdatRef = LLVMComdat*;

struct LLVMModuleFlagEntry;

struct LLVMOpaqueJITEventListener;
alias LLVMJITEventListenerRef = LLVMOpaqueJITEventListener*;

struct LLVMOpaqueBinary;
alias LLVMBinaryRef = LLVMOpaqueBinary*;
