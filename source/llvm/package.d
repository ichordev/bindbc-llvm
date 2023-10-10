/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

public import
	llvm.analysis,
	llvm.bitreader,
	llvm.bitwriter,
	llvm.blake3,
	llvm.comdat,
	llvm.core,
	llvm.debuginfo,
	llvm.disassembler,
	llvm.disassemblertypes,
	llvm.error,
	llvm.errorhandling,
	llvm.executionengine,
	llvm.ini,
	llvm.irreader,
	llvm.linker,
	llvm.lljit,
	llvm.lto,
	llvm.object,
	llvm.orc,
	llvm.orcee,
	llvm.remarks,
	llvm.support,
	llvm.target,
	llvm.targetmachine,
	llvm.types;

static if(!staticBinding):
import bindbc.loader;

mixin(makeDynloadFns("LLVM", makeLibPaths(["LLVM"], null), [
		"llvm.analysis",
		"llvm.bitreader",
		"llvm.bitwriter",
		"llvm.blake3",
		"llvm.comdat",
		"llvm.core",
		"llvm.debuginfo",
		"llvm.disassembler",
		"llvm.error",
		"llvm.errorhandling",
		"llvm.executionengine",
		"llvm.ini",
		"llvm.irreader",
		"llvm.linker",
		"llvm.lljit",
		"llvm.lto",
		"llvm.object",
		"llvm.orc",
		"llvm.orcee",
		"llvm.remarks",
		"llvm.support",
		"llvm.target",
		"llvm.targetmachine",
	]
));
