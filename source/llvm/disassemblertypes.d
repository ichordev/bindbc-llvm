/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.disassemblertypes;

alias LLVMDisasmContextRef = void*;

alias LLVMOpInfoCallback = extern(C) int function(void* disInfo, ulong pc, ulong offset, ulong opSize, ulong instSize, int tagType, void* tagBuf) nothrow;

struct LLVMOpInfoSymbol1{
	ulong present;
	const(char)* name;
	ulong value;
}

struct LLVMOpInfo1{
	LLVMOpInfoSymbol1 addSymbol;
	LLVMOpInfoSymbol1 subtractSymbol;
	ulong value;
	ulong variantKind;
}

enum{
	LLVMDisassembler_VariantKind_None              = 0,
	
	LLVMDisassembler_VariantKind_ARM_HI16          = 1,
	LLVMDisassembler_VariantKind_ARM_LO16          = 2,
	
	LLVMDisassembler_VariantKind_ARM64_PAGE        = 1,
	LLVMDisassembler_VariantKind_ARM64_PAGEOFF     = 2,
	LLVMDisassembler_VariantKind_ARM64_GOTPAGE     = 3,
	LLVMDisassembler_VariantKind_ARM64_GOTPAGEOFF  = 4,
	LLVMDisassembler_VariantKind_ARM64_TLVP        = 5,
	LLVMDisassembler_VariantKind_ARM64_TLVOFF      = 6,
}

alias LLVMSymbolLookupCallback = const(char)* function(void* disInfo, ulong referenceValue, ulong* referenceType, ulong referencePC, const(char)** referenceName);

enum{
	LLVMDisassembler_ReferenceType_InOut_None             = 0,
	
	LLVMDisassembler_ReferenceType_In_Branch              = 1,
	LLVMDisassembler_ReferenceType_In_PCrel_Load          = 2,
	
	LLVMDisassembler_ReferenceType_In_ARM64_ADRP          = 0x100000001,
	LLVMDisassembler_ReferenceType_In_ARM64_ADDXri        = 0x100000002,
	LLVMDisassembler_ReferenceType_In_ARM64_LDRXui        = 0x100000003,
	LLVMDisassembler_ReferenceType_In_ARM64_LDRXl         = 0x100000004,
	LLVMDisassembler_ReferenceType_In_ARM64_ADR           = 0x100000005,
	
	LLVMDisassembler_ReferenceType_Out_SymbolStub         = 1,
	LLVMDisassembler_ReferenceType_Out_LitPool_SymAddr    = 2,
	LLVMDisassembler_ReferenceType_Out_LitPool_CstrAddr   = 3,
	
	LLVMDisassembler_ReferenceType_Out_Objc_CFString_Ref  = 4,
	LLVMDisassembler_ReferenceType_Out_Objc_Message       = 5,
	LLVMDisassembler_ReferenceType_Out_Objc_Message_Ref   = 6,
	LLVMDisassembler_ReferenceType_Out_Objc_Selector_Ref  = 7,
	LLVMDisassembler_ReferenceType_Out_Objc_Class_Ref     = 8,
	
	LLVMDisassembler_ReferenceType_DeMangled_Name         = 9,
}
