/+
+            Copyright 2023 – 2024 Aya Partridge
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
	llvm.transforms,
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
		"llvm.transforms.instcombine",
		"llvm.transforms.ipo",
		"llvm.transforms.passbuilder",
		"llvm.transforms.passmanagerbuilder",
		"llvm.transforms.scalar",
		"llvm.transforms.utils",
		"llvm.transforms.vector",
		"llvm.targetmachine",
	]
));
