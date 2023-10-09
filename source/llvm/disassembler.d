/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.disassembler;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.disassemblertypes;

enum{
	LLVMDisassembler_Option_UseMarkup            = 1,
	LLVMDisassembler_Option_PrintImmHex          = 2,
	LLVMDisassembler_Option_AsmPrinterVariant    = 4,
	LLVMDisassembler_Option_SetInstrComments     = 8,
	LLVMDisassembler_Option_PrintLatency         = 16,
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMDisasmContextRef}, q{LLVMCreateDisasm}, q{const(char)* tripleName, void* disInfo, int tagType, LLVMOpInfoCallback getOpInfo, LLVMSymbolLookupCallback symbolLookUp}},
		{q{LLVMDisasmContextRef}, q{LLVMCreateDisasmCPU}, q{const(char)* triple, const(char)* cpu, void* disInfo, int tagType, LLVMOpInfoCallback getOpInfo, LLVMSymbolLookupCallback symbolLookUp}},
		{q{LLVMDisasmContextRef}, q{LLVMCreateDisasmCPUFeatures}, q{const(char)* triple, const(char)* cpu, const(char)* features, void* disInfo, int tagType, LLVMOpInfoCallback getOpInfo, LLVMSymbolLookupCallback symbolLookUp}},
		{q{int}, q{LLVMSetDisasmOptions}, q{LLVMDisasmContextRef dc, ulong options}},
		{q{void}, q{LLVMDisasmDispose}, q{LLVMDisasmContextRef dc}},
		{q{size_t}, q{LLVMDisasmInstruction}, q{LLVMDisasmContextRef dc, ubyte* bytes, ulong bytesSize, ulong pc, char* outString, size_t outStringSize}},
	];
	return ret;
}()));
