/+
+            Copyright 2023 – 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.object;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;
//#include "llvm/Config/llvm-config.h"

struct LLVMOpaqueSectionIterator;
alias LLVMSectionIteratorRef = LLVMOpaqueSectionIterator*;

struct LLVMOpaqueSymbolIterator;
alias LLVMSymbolIteratorRef = LLVMOpaqueSymbolIterator*;

struct LLVMOpaqueRelocationIterator;
alias LLVMRelocationIteratorRef = LLVMOpaqueRelocationIterator*;

alias LLVMBinaryType = int;
enum: LLVMBinaryType{
	LLVMBinaryTypeArchive,
	LLVMBinaryTypeMachOUniversalBinary,
	LLVMBinaryTypeCOFFImportFile,
	LLVMBinaryTypeIR,
	LLVMBinaryTypeWinRes,
	LLVMBinaryTypeCOFF,
	LLVMBinaryTypeELF32L,
	LLVMBinaryTypeELF32B,
	LLVMBinaryTypeELF64L,
	LLVMBinaryTypeELF64B,
	LLVMBinaryTypeMachO32L,
	LLVMBinaryTypeMachO32B,
	LLVMBinaryTypeMachO64L,
	LLVMBinaryTypeMachO64B,
	LLVMBinaryTypeWasm,
	LLVMBinaryTypeOffload,
}

struct LLVMOpaqueObjectFile;
alias LLVMObjectFileRef = LLVMOpaqueObjectFile*;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMBinaryRef}, q{LLVMCreateBinary}, q{LLVMMemoryBufferRef memBuf, LLVMContextRef context, char** errorMessage}},
		{q{void}, q{LLVMDisposeBinary}, q{LLVMBinaryRef br}},
		{q{LLVMMemoryBufferRef}, q{LLVMBinaryCopyMemoryBuffer}, q{LLVMBinaryRef br}},
		{q{LLVMBinaryType}, q{LLVMBinaryGetType}, q{LLVMBinaryRef br}},
		{q{LLVMBinaryRef}, q{LLVMMachOUniversalBinaryCopyObjectForArch}, q{LLVMBinaryRef br, const(char)* arch, size_t archLen, char** errorMessage}},
		{q{LLVMSectionIteratorRef}, q{LLVMObjectFileCopySectionIterator}, q{LLVMBinaryRef br}},
		{q{LLVMBool}, q{LLVMObjectFileIsSectionIteratorAtEnd}, q{LLVMBinaryRef br, LLVMSectionIteratorRef si}},
		{q{LLVMSymbolIteratorRef}, q{LLVMObjectFileCopySymbolIterator}, q{LLVMBinaryRef br}},
		{q{LLVMBool}, q{LLVMObjectFileIsSymbolIteratorAtEnd}, q{LLVMBinaryRef br, LLVMSymbolIteratorRef si}},
		{q{void}, q{LLVMDisposeSectionIterator}, q{LLVMSectionIteratorRef si}},
		{q{void}, q{LLVMMoveToNextSection}, q{LLVMSectionIteratorRef si}},
		{q{void}, q{LLVMMoveToContainingSection}, q{LLVMSectionIteratorRef sect, LLVMSymbolIteratorRef sym}},
		{q{void}, q{LLVMDisposeSymbolIterator}, q{LLVMSymbolIteratorRef si}},
		{q{void}, q{LLVMMoveToNextSymbol}, q{LLVMSymbolIteratorRef si}},
		{q{const(char)*}, q{LLVMGetSectionName}, q{LLVMSectionIteratorRef si}},
		{q{ulong}, q{LLVMGetSectionSize}, q{LLVMSectionIteratorRef si}},
		{q{const(char)*}, q{LLVMGetSectionContents}, q{LLVMSectionIteratorRef si}},
		{q{ulong}, q{LLVMGetSectionAddress}, q{LLVMSectionIteratorRef si}},
		{q{LLVMBool}, q{LLVMGetSectionContainsSymbol}, q{LLVMSectionIteratorRef si, LLVMSymbolIteratorRef sym}},
		{q{LLVMRelocationIteratorRef}, q{LLVMGetRelocations}, q{LLVMSectionIteratorRef section}},
		{q{void}, q{LLVMDisposeRelocationIterator}, q{LLVMRelocationIteratorRef ri}},
		{q{LLVMBool}, q{LLVMIsRelocationIteratorAtEnd}, q{LLVMSectionIteratorRef section, LLVMRelocationIteratorRef ri}},
		{q{void}, q{LLVMMoveToNextRelocation}, q{LLVMRelocationIteratorRef ri}},
		{q{const(char)*}, q{LLVMGetSymbolName}, q{LLVMSymbolIteratorRef si}},
		{q{ulong}, q{LLVMGetSymbolAddress}, q{LLVMSymbolIteratorRef si}},
		{q{ulong}, q{LLVMGetSymbolSize}, q{LLVMSymbolIteratorRef si}},
		{q{ulong}, q{LLVMGetRelocationOffset}, q{LLVMRelocationIteratorRef ri}},
		{q{LLVMSymbolIteratorRef}, q{LLVMGetRelocationSymbol}, q{LLVMRelocationIteratorRef ri}},
		{q{ulong}, q{LLVMGetRelocationType}, q{LLVMRelocationIteratorRef ri}},
		{q{const(char)*}, q{LLVMGetRelocationTypeName}, q{LLVMRelocationIteratorRef ri}},
		{q{const(char)*}, q{LLVMGetRelocationValueString}, q{LLVMRelocationIteratorRef ri}},
		{q{LLVMObjectFileRef}, q{LLVMCreateObjectFile}, q{LLVMMemoryBufferRef memBuf}},
		{q{void}, q{LLVMDisposeObjectFile}, q{LLVMObjectFileRef objectFile}},
		{q{LLVMSectionIteratorRef}, q{LLVMGetSections}, q{LLVMObjectFileRef objectFile}},
		{q{LLVMBool}, q{LLVMIsSectionIteratorAtEnd}, q{LLVMObjectFileRef objectFile, LLVMSectionIteratorRef si}},
		{q{LLVMSymbolIteratorRef}, q{LLVMGetSymbols}, q{LLVMObjectFileRef objectFile}},
		{q{LLVMBool}, q{LLVMIsSymbolIteratorAtEnd}, q{LLVMObjectFileRef objectFile, LLVMSymbolIteratorRef si}},
	];
	return ret;
}()));
