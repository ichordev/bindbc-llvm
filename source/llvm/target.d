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
//#include "llvm/Config/llvm-config.h"

alias LLVMByteOrdering = int;
enum: LLVMByteOrdering{
	LLVMBigEndian,
	LLVMLittleEndian,
}

struct LLVMOpaqueTargetData;
alias LLVMTargetDataRef = LLVMOpaqueTargetData*;

struct LLVMOpaqueTargetLibraryInfotData;
alias LLVMTargetLibraryInfoRef = LLVMOpaqueTargetLibraryInfotData*;

package enum string[] targets = {
	return ["AArch64", "AMDGPU", "ARM", "AVR", "BPF", "Hexagon", "Lanai", "LoongArch", "Mips", "MSP430", "NVPTX", "PowerPC", "RISCV", "Sparc", "SystemZ", "VE", "WebAssembly", "X86", "XCore"];
}();

mixin(joinFnBinds((){
	FnBind[] ret = [
LLVMTargetDataRef LLVMGetModuleDataLayout(LLVMModuleRef M);
void LLVMSetModuleDataLayout(LLVMModuleRef M, LLVMTargetDataRef DL);
LLVMTargetDataRef LLVMCreateTargetData(const char *StringRep);
void LLVMDisposeTargetData(LLVMTargetDataRef TD);
void LLVMAddTargetLibraryInfo(LLVMTargetLibraryInfoRef TLI, LLVMPassManagerRef PM);
char *LLVMCopyStringRepOfTargetData(LLVMTargetDataRef TD);
LLVMByteOrdering LLVMByteOrder(LLVMTargetDataRef TD);
unsigned LLVMPointerSize(LLVMTargetDataRef TD);
unsigned LLVMPointerSizeForAS(LLVMTargetDataRef TD, unsigned AS);
LLVMTypeRef LLVMIntPtrType(LLVMTargetDataRef TD);
LLVMTypeRef LLVMIntPtrTypeForAS(LLVMTargetDataRef TD, unsigned AS);
LLVMTypeRef LLVMIntPtrTypeInContext(LLVMContextRef C, LLVMTargetDataRef TD);
LLVMTypeRef LLVMIntPtrTypeForASInContext(LLVMContextRef C, LLVMTargetDataRef TD, unsigned AS);
unsigned long long LLVMSizeOfTypeInBits(LLVMTargetDataRef TD, LLVMTypeRef Ty);
unsigned long long LLVMStoreSizeOfType(LLVMTargetDataRef TD, LLVMTypeRef Ty);
unsigned long long LLVMABISizeOfType(LLVMTargetDataRef TD, LLVMTypeRef Ty);
unsigned LLVMABIAlignmentOfType(LLVMTargetDataRef TD, LLVMTypeRef Ty);
unsigned LLVMCallFrameAlignmentOfType(LLVMTargetDataRef TD, LLVMTypeRef Ty);
unsigned LLVMPreferredAlignmentOfType(LLVMTargetDataRef TD, LLVMTypeRef Ty);
unsigned LLVMPreferredAlignmentOfGlobal(LLVMTargetDataRef TD, LLVMValueRef GlobalVar);
unsigned LLVMElementAtOffset(LLVMTargetDataRef TD, LLVMTypeRef StructTy, unsigned long long Offset);
unsigned long long LLVMOffsetOfElement(LLVMTargetDataRef TD, LLVMTypeRef StructTy, unsigned Element);
	];
	static foreach(target; targets){
		mixin("version(LLVM_Target_"~target~"):");
		FnBind[] add = [
			{q{void}, "LLVMInitialize"~target~"TargetInfo", q{}, aliases: [q{"LLVMInitialise"~target~"TargetInfo"}]},
			{q{void}, "LLVMInitialize"~target~"Target", q{}, aliases: [q{"LLVMInitialise"~target~"Target"}]},
			{q{void}, "LLVMInitialize"~target~"TargetMC", q{}, aliases: [q{"LLVMInitialise"~target~"TargetMC"}]},
		];
		ret ~= add;
	}
	static foreach(){
#define LLVM_ASM_PRINTER(TargetName) \
	void LLVMInitialize##TargetName##AsmPrinter();
#include "llvm/Config/AsmPrinters.def"
#undef LLVM_ASM_PRINTER
	
#define LLVM_ASM_PARSER(TargetName) \
	void LLVMInitialize##TargetName##AsmParser();
#include "llvm/Config/AsmParsers.def"
#undef LLVM_ASM_PARSER
}
	}
	static foreach(){
#define LLVM_DISASSEMBLER(TargetName) \
	void LLVMInitialize##TargetName##Disassembler();
#include "llvm/Config/Disassemblers.def"
#undef LLVM_DISASSEMBLER
	}
	return ret;
}()));

static inline void LLVMInitializeAllTargetInfos() {
#define LLVM_TARGET(TargetName) LLVMInitialize##TargetName##TargetInfo();
#include "llvm/Config/Targets.def"
#undef LLVM_TARGET
}

static inline void LLVMInitializeAllTargets() {
#define LLVM_TARGET(TargetName) LLVMInitialize##TargetName##Target();
#include "llvm/Config/Targets.def"
#undef LLVM_TARGET
}

static inline void LLVMInitializeAllTargetMCs() {
#define LLVM_TARGET(TargetName) LLVMInitialize##TargetName##TargetMC();
#include "llvm/Config/Targets.def"
#undef LLVM_TARGET
}

static inline void LLVMInitializeAllAsmPrinters() {
#define LLVM_ASM_PRINTER(TargetName) LLVMInitialize##TargetName##AsmPrinter();
#include "llvm/Config/AsmPrinters.def"
#undef LLVM_ASM_PRINTER
}

static inline void LLVMInitializeAllAsmParsers() {
#define LLVM_ASM_PARSER(TargetName) LLVMInitialize##TargetName##AsmParser();
#include "llvm/Config/AsmParsers.def"
#undef LLVM_ASM_PARSER
}

static inline void LLVMInitializeAllDisassemblers() {
#define LLVM_DISASSEMBLER(TargetName) \
	LLVMInitialize##TargetName##Disassembler();
#include "llvm/Config/Disassemblers.def"
#undef LLVM_DISASSEMBLER
}

static inline LLVMBool LLVMInitializeNativeTarget() {

#ifdef LLVM_NATIVE_TARGET
	LLVM_NATIVE_TARGETINFO();
	LLVM_NATIVE_TARGET();
	LLVM_NATIVE_TARGETMC();
	return 0;
#else
	return 1;
#endif
}

static inline LLVMBool LLVMInitializeNativeAsmParser(void) {
#ifdef LLVM_NATIVE_ASMPARSER
	LLVM_NATIVE_ASMPARSER();
	return 0;
#else
	return 1;
#endif
}

static inline LLVMBool LLVMInitializeNativeAsmPrinter(void) {
#ifdef LLVM_NATIVE_ASMPRINTER
	LLVM_NATIVE_ASMPRINTER();
	return 0;
#else
	return 1;
#endif
}

static inline LLVMBool LLVMInitializeNativeDisassembler(void) {
#ifdef LLVM_NATIVE_DISASSEMBLER
	LLVM_NATIVE_DISASSEMBLER();
	return 0;
#else
	return 1;
#endif
}
