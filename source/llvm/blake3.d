/+
+            Copyright 2023 – 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.blake3;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

enum LLVM_BLAKE3_VERSION_STRING = "1.3.1";
enum LLVM_BLAKE3_KEY_LEN = 32;
enum LLVM_BLAKE3_OUT_LEN = 32;
enum LLVM_BLAKE3_BLOCK_LEN = 64;
enum LLVM_BLAKE3_CHUNK_LEN = 1024;
enum LLVM_BLAKE3_MAX_DEPTH = 54;

struct llvm_blake3_chunk_state{
	uint[8] cv;
	ulong chunk_counter;
	ubyte[LLVM_BLAKE3_BLOCK_LEN] buf;
	ubyte buf_len;
	ubyte blocks_compressed;
	ubyte flags;
}

struct llvm_blake3_hasher{
	uint[8] key;
	llvm_blake3_chunk_state chunk;
	ubyte cv_stack_len;
	ubyte[(LLVM_BLAKE3_MAX_DEPTH + 1) * LLVM_BLAKE3_OUT_LEN] cv_stack;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{const(char)*}, q{llvm_blake3_version}, q{}},
		{q{void}, q{llvm_blake3_hasher_init}, q{llvm_blake3_hasher* self}},
		{q{void}, q{llvm_blake3_hasher_init_keyed}, q{llvm_blake3_hasher* self, ref const(ubyte)[LLVM_BLAKE3_KEY_LEN] key}},
		{q{void}, q{llvm_blake3_hasher_init_derive_key}, q{llvm_blake3_hasher* self, const(char)* context}},
		{q{void}, q{llvm_blake3_hasher_init_derive_key_raw}, q{llvm_blake3_hasher* self, const(void)* context, size_t context_len}},
		{q{void}, q{llvm_blake3_hasher_update}, q{llvm_blake3_hasher* self, const(void)* input, size_t input_len}},
		{q{void}, q{llvm_blake3_hasher_finalize}, q{const(llvm_blake3_hasher)* self, ubyte* out_, size_t out_len}},
		{q{void}, q{llvm_blake3_hasher_finalize_seek}, q{const(llvm_blake3_hasher)* self, ulong seek, ubyte* out_, size_t out_len}},
		{q{void}, q{llvm_blake3_hasher_reset}, q{llvm_blake3_hasher* self}},
	];
	return ret;
}()));
