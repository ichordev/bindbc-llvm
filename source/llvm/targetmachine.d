/+
+            Copyright 2023 – 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.targetmachine;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.target;
import llvm.types;

struct LLVMOpaqueTargetMachine;
alias LLVMTargetMachineRef = LLVMOpaqueTargetMachine*;

struct LLVMTarget;
alias LLVMTargetRef = LLVMTarget*;

alias LLVMCodeGenOptLevel = int;
enum: LLVMCodeGenOptLevel{
	LLVMCodeGenLevelNone,
	LLVMCodeGenLevelLess,
	LLVMCodeGenLevelDefault,
	LLVMCodeGenLevelAggressive,
}

alias LLVMRelocMode = int;
enum: LLVMRelocMode{
	LLVMRelocDefault,
	LLVMRelocStatic,
	LLVMRelocPIC,
	LLVMRelocDynamicNoPic,
	LLVMRelocROPI,
	LLVMRelocRWPI,
	LLVMRelocROPI_RWPI,
}

alias LLVMCodeModel = int;
enum: LLVMCodeModel{
	LLVMCodeModelDefault,
	LLVMCodeModelJITDefault,
	LLVMCodeModelTiny,
	LLVMCodeModelSmall,
	LLVMCodeModelKernel,
	LLVMCodeModelMedium,
	LLVMCodeModelLarge,
}

alias LLVMCodeGenFileType = int;
enum: LLVMCodeGenFileType{
	LLVMAssemblyFile,
	LLVMObjectFile,
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMTargetRef}, q{LLVMGetFirstTarget}, q{}},
		{q{LLVMTargetRef}, q{LLVMGetNextTarget}, q{LLVMTargetRef t}},
		{q{LLVMTargetRef}, q{LLVMGetTargetFromName}, q{const(char)* name}},
		{q{LLVMBool}, q{LLVMGetTargetFromTriple}, q{const(char)* triple, LLVMTargetRef* t, char** errorMessage}},
		{q{const(char)*}, q{LLVMGetTargetName}, q{LLVMTargetRef t}},
		{q{const(char)*}, q{LLVMGetTargetDescription}, q{LLVMTargetRef t}},
		{q{LLVMBool}, q{LLVMTargetHasJIT}, q{LLVMTargetRef t}},
		{q{LLVMBool}, q{LLVMTargetHasTargetMachine}, q{LLVMTargetRef t}},
		{q{LLVMBool}, q{LLVMTargetHasAsmBackend}, q{LLVMTargetRef t}},
		{q{LLVMTargetMachineRef}, q{LLVMCreateTargetMachine}, q{LLVMTargetRef t, const(char)* triple, const(char)* cpu, const(char)* features, LLVMCodeGenOptLevel level, LLVMRelocMode reloc, LLVMCodeModel codeModel}},
		{q{void}, q{LLVMDisposeTargetMachine}, q{LLVMTargetMachineRef t}},
		{q{LLVMTargetRef}, q{LLVMGetTargetMachineTarget}, q{LLVMTargetMachineRef t}},
		{q{char*}, q{LLVMGetTargetMachineTriple}, q{LLVMTargetMachineRef t}},
		{q{char*}, q{LLVMGetTargetMachineCPU}, q{LLVMTargetMachineRef t}},
		{q{char*}, q{LLVMGetTargetMachineFeatureString}, q{LLVMTargetMachineRef t}},
		{q{LLVMTargetDataRef}, q{LLVMCreateTargetDataLayout}, q{LLVMTargetMachineRef t}},
		{q{void}, q{LLVMSetTargetMachineAsmVerbosity}, q{LLVMTargetMachineRef t, LLVMBool verboseAsm}},
		{q{LLVMBool}, q{LLVMTargetMachineEmitToFile}, q{LLVMTargetMachineRef t, LLVMModuleRef m, const(char)* filename, LLVMCodeGenFileType codegen, char** errorMessage}},
		{q{LLVMBool}, q{LLVMTargetMachineEmitToMemoryBuffer}, q{LLVMTargetMachineRef t, LLVMModuleRef m, LLVMCodeGenFileType codegen, char** errorMessage, LLVMMemoryBufferRef *outMemBuf}},
		{q{char*}, q{LLVMGetDefaultTargetTriple}, q{}},
		{q{char*}, q{LLVMNormalizeTargetTriple}, q{const(char)* triple}},
		{q{char*}, q{LLVMGetHostCPUName}, q{}},
		{q{char*}, q{LLVMGetHostCPUFeatures}, q{}},
		{q{void}, q{LLVMAddAnalysisPasses}, q{LLVMTargetMachineRef t, LLVMPassManagerRef pm}},
	];
	return ret;
}()));
