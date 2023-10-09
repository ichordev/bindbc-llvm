/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module bindbc.llvm.config;

enum staticBinding = (){
	version(BindBC_Static)        return true;
	else version(BindLLVM_Static) return true;
	else return false;
}();

public import bindbc.common.versions;

enum llvmVersion = (){
	version(LLVM_17_0) return Version(17,0,0);
	else               return Version(16,0,0);
}();
