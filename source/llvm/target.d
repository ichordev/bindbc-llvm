/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software license, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.target;

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

private enum: string[]{
	targets = {
		static if(llvmVersion >= Version(17,0,0))
		static assert(0, "Version not supported yet.");
		else static if(llvmVersion >= Version(16,0,0))
		return ["AArch64", "AMDGPU", "ARC", "ARM", "AVR", "BPF", "CSKY", "DirectX", "Hexagon", "Lanai", "LoongArch", "M68k", "Mips", "MSP430", "NVPTX", "PowerPC", "RISCV", "Sparc", "SPIRV", "SystemZ", "VE", "WebAssembly", "X86", "XCore", "Xtensa"];
	}(),
	asmPrinters = {
		static if(llvmVersion >= Version(17,0,0))
		static assert(0, "Version not supported yet.");
		else static if(llvmVersion >= Version(16,0,0))
		return ["AArch64", "AMDGPU", "ARM", "AVR", "BPF", "CSKY", "Hexagon", "Lanai", "LoongArch", "M68k", "Mips", "MSP430", "PowerPC", "RISCV", "Sparc", "SystemZ", "VE", "WebAssembly", "X86", "Xtensa"];
	}(),
	disassemblers = {
		static if(llvmVersion >= Version(17,0,0))
		static assert(0, "Version not supported yet.");
		else static if(llvmVersion >= Version(16,0,0))
		return ["AArch64", "AMDGPU", "ARC", "ARM", "AVR", "BPF", "CSKY", "Hexagon", "Lanai", "LoongArch", "M68k", "Mips", "MSP430", "PowerPC", "RISCV", "Sparc", "SystemZ", "VE", "WebAssembly", "X86", "XCore", "Xtensa"];
	}(),
}

private enum getTargetVersions = (string target){
	switch(target){
		case "Mips": return ["MIPS32", "MIPS64"];
		case "NVPTX": return ["NVPTX", "NVPTX64"];
		case "PowerPC": return ["PPC", "PPC64"];
		case "RISCV": return ["RISCV32", "RISCV64"];
		case "Sparc": return ["SPARC", "SPARC64"];
		case "X86": return ["X86", "X86_64"];
		default: return [target];
	}
};

private enum makeTargetCondition = (string target){
	string ret = "{\n";
	foreach(v; getTargetVersions(target)){
		ret ~= "version("~v~") return true;\n\telse ";
	}
	ret ~= "return false;";
	ret ~= "\n}()";
	return ret;
};

private enum nativeTarget = {
	mixin({
		string ret;
		static foreach(target; targets){
			ret ~= "static if("~makeTargetCondition(target)~") return \""~target~"\";\nelse ";
		}
		ret ~= "return cast(string)null;";
		return ret;
	}());
}();

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMTargetDataRef}, q{LLVMGetModuleDataLayout}, q{LLVMModuleRef m}},
		{q{void}, q{LLVMSetModuleDataLayout}, q{LLVMModuleRef m, LLVMTargetDataRef dl}},
		{q{LLVMTargetDataRef}, q{LLVMCreateTargetData}, q{const(char)* stringRep}},
		{q{void}, q{LLVMDisposeTargetData}, q{LLVMTargetDataRef td}},
		{q{void}, q{LLVMAddTargetLibraryInfo}, q{LLVMTargetLibraryInfoRef tli, LLVMPassManagerRef pm}},
		{q{char*}, q{LLVMCopyStringRepOfTargetData}, q{LLVMTargetDataRef td}},
		{q{LLVMByteOrdering}, q{LLVMByteOrder}, q{LLVMTargetDataRef td}},
		{q{uint}, q{LLVMPointerSize}, q{LLVMTargetDataRef td}},
		{q{uint}, q{LLVMPointerSizeForAS}, q{LLVMTargetDataRef td, uint as}},
		{q{LLVMTypeRef}, q{LLVMIntPtrType}, q{LLVMTargetDataRef td}},
		{q{LLVMTypeRef}, q{LLVMIntPtrTypeForAS}, q{LLVMTargetDataRef td, uint as}},
		{q{LLVMTypeRef}, q{LLVMIntPtrTypeInContext}, q{LLVMContextRef c, LLVMTargetDataRef td}},
		{q{LLVMTypeRef}, q{LLVMIntPtrTypeForASInContext}, q{LLVMContextRef c, LLVMTargetDataRef td, uint as}},
		{q{ulong}, q{LLVMSizeOfTypeInBits}, q{LLVMTargetDataRef td, LLVMTypeRef ty}},
		{q{ulong}, q{LLVMStoreSizeOfType}, q{LLVMTargetDataRef td, LLVMTypeRef ty}},
		{q{ulong}, q{LLVMABISizeOfType}, q{LLVMTargetDataRef td, LLVMTypeRef ty}},
		{q{uint}, q{LLVMABIAlignmentOfType}, q{LLVMTargetDataRef td, LLVMTypeRef ty}},
		{q{uint}, q{LLVMCallFrameAlignmentOfType}, q{LLVMTargetDataRef td, LLVMTypeRef ty}},
		{q{uint}, q{LLVMPreferredAlignmentOfType}, q{LLVMTargetDataRef td, LLVMTypeRef ty}},
		{q{uint}, q{LLVMPreferredAlignmentOfGlobal}, q{LLVMTargetDataRef td, LLVMValueRef globalVar}},
		{q{uint}, q{LLVMElementAtOffset}, q{LLVMTargetDataRef td, LLVMTypeRef structTy, ulong offset}},
		{q{ulong}, q{LLVMOffsetOfElement}, q{LLVMTargetDataRef td, LLVMTypeRef structTy, uint element}},
	];
	static foreach(target; targets){{
		mixin(
		`static if(nativeTarget == "`~target~`" || { version(LLVM_Target_`~target~`) return true; else return false; }()){
			FnBind[] add = [
				{q{void}, q{LLVMInitialize`~target~`TargetInfo}, q{}, aliases: [q{LLVMInitialise`~target~`TargetInfo}]},
				{q{void}, q{LLVMInitialize`~target~`Target}, q{}, aliases: [q{LLVMInitialise`~target~`Target}]},
				{q{void}, q{LLVMInitialize`~target~`TargetMC}, q{}, aliases: [q{LLVMInitialise`~target~`TargetMC}]},
			];
			ret ~= add;
		}`);
	}}
	static foreach(target; asmPrinters){{
		mixin(
		`static if(nativeTarget == "`~target~`" || { version(LLVM_Target_`~target~`) return true; else return false; }()){
			FnBind[] add = [
				{q{void}, q{LLVMInitialize`~target~`AsmPrinter}, q{}, aliases: [q{LLVMInitialise`~target~`AsmPrinter}]},
				{q{void}, q{LLVMInitialize`~target~`AsmParser}, q{}, aliases: [q{LLVMInitialise`~target~`AsmParser}]},
			];
			ret ~= add;
		}`);
	}}
	static foreach(target; disassemblers){{
		mixin(
		`static if(nativeTarget == "`~target~`" || { version(LLVM_Target_`~target~`) return true; else return false; }()){
			FnBind[] add = [
				{q{void}, q{LLVMInitialize`~target~`Disassembler}, q{}, aliases: [q{LLVMInitialise`~target~`Disassembler}]},
			];
			ret ~= add;
		}`);
	}}
	return ret;
}()));

pragma(inline,true) nothrow @nogc{
	void LLVMInitializeAllTargetInfos(){
		static foreach(target; targets){
			mixin("version(LLVM_Target_"~target~") LLVMInitialize"~target~"TargetInfo();");
		}
	}
	alias LLVMInitialiseAllTargetInfos = LLVMInitializeAllTargetInfos;
	
	void LLVMInitializeAllTargets(){
		static foreach(target; targets){
			mixin("version(LLVM_Target_"~target~") LLVMInitialize"~target~"Target();");
		}
	}
	alias LLVMInitialiseAllTargets = LLVMInitializeAllTargets;
	
	void LLVMInitializeAllTargetMCs(){
		static foreach(target; targets){
			mixin("version(LLVM_Target_"~target~") LLVMInitialize"~target~"TargetMC();");
		}
	}
	alias LLVMInitialiseAllTargetMCs = LLVMInitializeAllTargetMCs;
	
	void LLVMInitializeAllAsmPrinters(){
		static foreach(target; asmPrinters){
			mixin("version(LLVM_Target_"~target~") LLVMInitialize"~target~"AsmPrinter();");
		}
	}
	alias LLVMInitialiseAllAsmPrinters = LLVMInitializeAllAsmPrinters;
	
	void LLVMInitializeAllAsmParsers(){
		static foreach(target; asmPrinters){
			mixin("version(LLVM_Target_"~target~") LLVMInitialize"~target~"AsmParser();");
		}
	}
	alias LLVMInitialiseAllAsmParsers = LLVMInitializeAllAsmParsers;
	
	void LLVMInitializeAllDisassemblers(){
		static foreach(target; disassemblers){
			mixin("version(LLVM_Target_"~target~") LLVMInitialize"~target~"Disassembler();");
		}
	}
	alias LLVMInitialiseAllDisassemblers = LLVMInitializeAllDisassemblers;
	
	LLVMBool LLVMInitializeNativeTarget(){
		static if(nativeTarget.length){
			mixin("LLVMInitialize"~nativeTarget~"TargetInfo();");
			mixin("LLVMInitialize"~nativeTarget~"Target();");
			mixin("LLVMInitialize"~nativeTarget~"TargetMC();");
			return false;
		}else return true;
	}
	alias LLVMInitialiseNativeTarget = LLVMInitializeNativeTarget;
	
	LLVMBool LLVMInitializeNativeAsmParser(){
		static if(nativeTarget.length){
			mixin("LLVMInitialize"~nativeTarget~"AsmParser();");
			return false;
		}else return true;
	}
	alias LLVMInitialiseNativeAsmParser = LLVMInitializeNativeAsmParser;
	
	LLVMBool LLVMInitializeNativeAsmPrinter(){
		static if(nativeTarget.length){
			mixin("LLVMInitialize"~nativeTarget~"AsmPrinter();");
			return false;
		}else return true;
	}
	alias LLVMInitialiseNativeAsmPrinter = LLVMInitializeNativeAsmPrinter;
	
	LLVMBool LLVMInitializeNativeDisassembler(){
		static if(nativeTarget.length){
			mixin("LLVMInitialize"~nativeTarget~"Disassembler();");
			return false;
		}else return true;
	}
	alias LLVMInitialiseNativeDisassembler = LLVMInitializeNativeDisassembler;
}
