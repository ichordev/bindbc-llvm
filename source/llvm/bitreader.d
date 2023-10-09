/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.bitreader;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{LLVMBool}, q{LLVMParseBitcode}, q{LLVMMemoryBufferRef MemBuf, LLVMModuleRef* OutModule, char** OutMessage}},
		{q{LLVMBool}, q{LLVMParseBitcode2}, q{LLVMMemoryBufferRef MemBuf, LLVMModuleRef* OutModule}},
		{q{LLVMBool}, q{LLVMParseBitcodeInContext}, q{LLVMContextRef ContextRef, LLVMMemoryBufferRef MemBuf, LLVMModuleRef* OutModule, char** OutMessage}},
		{q{LLVMBool}, q{LLVMParseBitcodeInContext2}, q{LLVMContextRef ContextRef, LLVMMemoryBufferRef MemBuf, LLVMModuleRef* OutModule}},
		{q{LLVMBool}, q{LLVMGetBitcodeModuleInContext}, q{LLVMContextRef ContextRef, LLVMMemoryBufferRef MemBuf, LLVMModuleRef* OutM, char** OutMessage}},
		{q{LLVMBool}, q{LLVMGetBitcodeModuleInContext2}, q{LLVMContextRef ContextRef, LLVMMemoryBufferRef MemBuf, LLVMModuleRef* OutM}},
		{q{LLVMBool}, q{LLVMGetBitcodeModule}, q{LLVMMemoryBufferRef MemBuf, LLVMModuleRef* OutM, char** OutMessage}},
		{q{LLVMBool}, q{LLVMGetBitcodeModule2}, q{LLVMMemoryBufferRef MemBuf, LLVMModuleRef *OutM}},
	];
	return ret;
}()));
