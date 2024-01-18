/+
+            Copyright 2023 – 2024 Aya Partridge
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
		{q{LLVMBool}, q{LLVMParseBitcode}, q{LLVMMemoryBufferRef memBuf, LLVMModuleRef* outModule, char** outMessage}},
		{q{LLVMBool}, q{LLVMParseBitcode2}, q{LLVMMemoryBufferRef memBuf, LLVMModuleRef* outModule}},
		{q{LLVMBool}, q{LLVMParseBitcodeInContext}, q{LLVMContextRef contextRef, LLVMMemoryBufferRef memBuf, LLVMModuleRef* outModule, char** outMessage}},
		{q{LLVMBool}, q{LLVMParseBitcodeInContext2}, q{LLVMContextRef contextRef, LLVMMemoryBufferRef memBuf, LLVMModuleRef* outModule}},
		{q{LLVMBool}, q{LLVMGetBitcodeModuleInContext}, q{LLVMContextRef contextRef, LLVMMemoryBufferRef memBuf, LLVMModuleRef* outM, char** outMessage}},
		{q{LLVMBool}, q{LLVMGetBitcodeModuleInContext2}, q{LLVMContextRef contextRef, LLVMMemoryBufferRef memBuf, LLVMModuleRef* outM}},
		{q{LLVMBool}, q{LLVMGetBitcodeModule}, q{LLVMMemoryBufferRef memBuf, LLVMModuleRef* outM, char** outMessage}},
		{q{LLVMBool}, q{LLVMGetBitcodeModule2}, q{LLVMMemoryBufferRef memBuf, LLVMModuleRef* outM}},
	];
	return ret;
}()));
