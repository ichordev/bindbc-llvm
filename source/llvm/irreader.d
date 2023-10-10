/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.irreader;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

import llvm.types;

mixin(joinFnBinds((){
    FnBind[] ret = [
        {q{LLVMBool}, q{LLVMParseIRInContext}, q{LLVMContextRef contextRef, LLVMMemoryBufferRef memBuf, LLVMModuleRef* outM, char** outMessage}},
    ];
    return ret;
}()));
