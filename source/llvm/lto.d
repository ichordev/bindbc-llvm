/+
+                Copyright 2023 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module llvm.lto;

import bindbc.llvm.config;
import bindbc.llvm.codegen;

//#include <sys/types.h>

enum LTO_API_VERSION = {
	static if(llvmVersion >= Version(17,0,0)) static assert(0, "17.X.X is not supported yet.");
	else static if(llvmVersion >= Version(16,0,0)) return 29;
}();

alias lto_symbol_attributes = int;
enum: lto_symbol_attributes{
	LTO_SYMBOL_ALIGNMENT_MASK               = 0x0000001F,
	LTO_SYMBOL_PERMISSIONS_MASK             = 0x000000E0,
	LTO_SYMBOL_PERMISSIONS_CODE             = 0x000000A0,
	LTO_SYMBOL_PERMISSIONS_DATA             = 0x000000C0,
	LTO_SYMBOL_PERMISSIONS_RODATA           = 0x00000080,
	LTO_SYMBOL_DEFINITION_MASK              = 0x00000700,
	LTO_SYMBOL_DEFINITION_REGULAR           = 0x00000100,
	LTO_SYMBOL_DEFINITION_TENTATIVE         = 0x00000200,
	LTO_SYMBOL_DEFINITION_WEAK              = 0x00000300,
	LTO_SYMBOL_DEFINITION_UNDEFINED         = 0x00000400,
	LTO_SYMBOL_DEFINITION_WEAKUNDEF         = 0x00000500,
	LTO_SYMBOL_SCOPE_MASK                   = 0x00003800,
	LTO_SYMBOL_SCOPE_INTERNAL               = 0x00000800,
	LTO_SYMBOL_SCOPE_HIDDEN                 = 0x00001000,
	LTO_SYMBOL_SCOPE_PROTECTED              = 0x00002000,
	LTO_SYMBOL_SCOPE_DEFAULT                = 0x00001800,
	LTO_SYMBOL_SCOPE_DEFAULT_CAN_BE_HIDDEN  = 0x00002800,
	LTO_SYMBOL_COMDAT                       = 0x00004000,
	LTO_SYMBOL_ALIAS                        = 0x00008000,
}

alias lto_debug_model = int;
enum: lto_debug_model{
	LTO_DEBUG_MODEL_NONE     = 0,
	LTO_DEBUG_MODEL_DWARF    = 1,
}

alias lto_codegen_model = int;
enum: lto_codegen_model{
	LTO_CODEGEN_PIC_MODEL_STATIC          = 0,
	LTO_CODEGEN_PIC_MODEL_DYNAMIC         = 1,
	LTO_CODEGEN_PIC_MODEL_DYNAMIC_NO_PIC  = 2,
	LTO_CODEGEN_PIC_MODEL_DEFAULT         = 3,
}

struct LLVMOpaqueLTOModule;
alias lto_module_t = LLVMOpaqueLTOModule*;

struct LLVMOpaqueLTOCodeGenerator;
alias lto_code_gen_t = LLVMOpaqueLTOCodeGenerator*;

struct LLVMOpaqueThinLTOCodeGenerator;
alias thinlto_code_gen_t = LLVMOpaqueThinLTOCodeGenerator*;

alias lto_codegen_diagnostic_severity_t = int;
enum: lto_codegen_diagnostic_severity_t{
	LTO_DS_ERROR = 0,
	LTO_DS_WARNING = 1,
	LTO_DS_REMARK = 3,
}

alias lto_diagnostic_handler_t = extern(C) void function(lto_codegen_diagnostic_severity_t severity, const(char)* diag, void* ctxt) nothrow;

struct LLVMOpaqueLTOInput;
alias lto_input_t = LLVMOpaqueLTOInput*;

struct LTOObjectBuffer{
	const(char)* buffer;
	size_t size;
}

mixin(joinFnBinds((){
	FnBind[] ret;
	if(LTO_API_VERSION >= 3){
		FnBind[] add = [
			{q{const(char)*}, q{lto_get_version}, q{}},
			{q{const(char)*}, q{lto_get_error_message}, q{}},
			{q{bool}, q{lto_module_is_object_file}, q{const(char)* path}},
			{q{bool}, q{lto_module_is_object_file_for_target}, q{const(char)* path, const(char)* target_triple_prefix}},
			{q{bool}, q{lto_module_is_object_file_in_memory}, q{const(void)* mem, size_t length}},
			{q{bool}, q{lto_module_is_object_file_in_memory_for_target}, q{const(void)* mem, size_t length, const(char)* target_triple_prefix}},
			{q{lto_module_t}, q{lto_module_create}, q{const(char)* path}},
			{q{lto_module_t}, q{lto_module_create_from_memory}, q{const(void)* mem, size_t length}},
			{q{void}, q{lto_module_dispose}, q{lto_module_t mod}},
			{q{const(char)*}, q{lto_module_get_target_triple}, q{lto_module_t mod}},
			{q{uint}, q{lto_module_get_num_symbols}, q{lto_module_t mod}},
			{q{const(char)*}, q{lto_module_get_symbol_name}, q{lto_module_t mod, uint index}},
			{q{lto_symbol_attributes}, q{lto_module_get_symbol_attribute}, q{lto_module_t mod, uint index}},
			{q{lto_code_gen_t}, q{lto_codegen_create}, q{}},
			{q{void}, q{lto_codegen_dispose}, q{lto_code_gen_t}},
			{q{bool}, q{lto_codegen_add_module}, q{lto_code_gen_t cg, lto_module_t mod}},
			{q{bool}, q{lto_codegen_set_debug_model}, q{lto_code_gen_t cg, lto_debug_model}},
			{q{bool}, q{lto_codegen_set_pic_model}, q{lto_code_gen_t cg, lto_codegen_model}},
			{q{void}, q{lto_codegen_set_assembler_path}, q{lto_code_gen_t cg, const(char)* path}},
			{q{void}, q{lto_codegen_add_must_preserve_symbol}, q{lto_code_gen_t cg, const(char)* symbol}},
			{q{const(void)*}, q{lto_codegen_compile}, q{lto_code_gen_t cg, size_t* length}},
			{q{void}, q{lto_codegen_debug_options}, q{lto_code_gen_t cg, const(char)* }},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 4){
		FnBind[] add = [
			{q{void}, q{lto_module_set_target_triple}, q{lto_module_t mod, const(char)* triple}},
			{q{void}, q{lto_codegen_set_cpu}, q{lto_code_gen_t cg, const(char)* cpu}},
			{q{void}, q{lto_codegen_set_assembler_args}, q{lto_code_gen_t cg, const(char)** args, int nargs}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 5){
		FnBind[] add = [
			{q{lto_module_t}, q{lto_module_create_from_fd}, q{int fd, const(char)* path, size_t file_size}},
			{q{lto_module_t}, q{lto_module_create_from_fd_at_offset}, q{int fd, const(char)* path, size_t file_size, size_t map_size, ptrdiff_t offset}},
			{q{bool}, q{lto_codegen_write_merged_modules}, q{lto_code_gen_t cg, const(char)* path}},
			{q{bool}, q{lto_codegen_compile_to_file}, q{lto_code_gen_t cg, const(char)** name}},
			{q{void}, q{lto_initialize_disassembler}, q{}, aliases: [q{lto_initialise_disassembler}]},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 7){
		FnBind[] add = [
			{q{void}, q{lto_codegen_set_diagnostic_handler}, q{lto_code_gen_t, lto_diagnostic_handler_t, void*}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 9){
		FnBind[] add = [
			{q{lto_module_t}, q{lto_module_create_from_memory_with_path}, q{const(void)* mem, size_t length, const(char)* path}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 11){
		FnBind[] add = [
			{q{lto_module_t}, q{lto_module_create_in_local_context}, q{const(void)* mem, size_t length, const(char)* path}},
			{q{lto_module_t}, q{lto_module_create_in_codegen_context}, q{const(void)* mem, size_t length, const(char)* path, lto_code_gen_t cg}},
			{q{lto_code_gen_t}, q{lto_codegen_create_in_local_context}, q{}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 12){
		FnBind[] add = [
			{q{bool}, q{lto_codegen_optimize}, q{lto_code_gen_t cg}, aliases: [q{lto_codegen_optimise}]},
			{q{const(void)*}, q{lto_codegen_compile_optimized}, q{lto_code_gen_t cg, size_t* length}, aliases: [q{lto_codegen_compile_optimised}]},
			{q{uint}, q{lto_api_version}, q{}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 13){
		FnBind[] add = [
			{q{void}, q{lto_codegen_set_module}, q{lto_code_gen_t cg, lto_module_t mod}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 14){
		FnBind[] add = [
			{q{void}, q{lto_codegen_set_should_internalize}, q{lto_code_gen_t cg, bool shouldInternalise}, aliases: [q{lto_codegen_set_should_internalise}]},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 15){
		FnBind[] add = [
			{q{void}, q{lto_codegen_set_should_embed_uselists}, q{lto_code_gen_t cg, bool shouldEmbedUselists}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 16){
		FnBind[] add = [
			{q{const(char)*}, q{lto_module_get_linkeropts}, q{lto_module_t mod}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 18){
		FnBind[] add = [
			{q{thinlto_code_gen_t}, q{thinlto_create_codegen}, q{}},
			{q{void}, q{thinlto_codegen_dispose}, q{thinlto_code_gen_t cg}},
			{q{void}, q{thinlto_codegen_add_module}, q{thinlto_code_gen_t cg, const(char)* identifier, const(char)* data, int length}},
			{q{void}, q{thinlto_codegen_process}, q{thinlto_code_gen_t cg}},
			{q{uint}, q{thinlto_module_get_num_objects}, q{thinlto_code_gen_t cg}},
			{q{LTOObjectBuffer}, q{thinlto_module_get_object}, q{thinlto_code_gen_t cg, uint index}},
			{q{bool}, q{thinlto_codegen_set_pic_model}, q{thinlto_code_gen_t cg, lto_codegen_model}},
			{q{void}, q{thinlto_codegen_set_savetemps_dir}, q{thinlto_code_gen_t cg, const(char)* save_temps_dir}},
			{q{void}, q{thinlto_codegen_set_cpu}, q{thinlto_code_gen_t cg, const(char)* cpu}},
			{q{void}, q{thinlto_debug_options}, q{const(char*)* options, int number}},
			{q{bool}, q{lto_module_is_thinlto}, q{lto_module_t mod}},
			{q{void}, q{thinlto_codegen_add_must_preserve_symbol}, q{thinlto_code_gen_t cg, const(char)* name, int length}},
			{q{void}, q{thinlto_codegen_add_cross_referenced_symbol}, q{thinlto_code_gen_t cg, const(char)* name, int length}},
			{q{void}, q{thinlto_codegen_set_cache_dir}, q{thinlto_code_gen_t cg, const(char)* cache_dir}},
			{q{void}, q{thinlto_codegen_set_cache_pruning_interval}, q{thinlto_code_gen_t cg, int interval}},
			{q{void}, q{thinlto_codegen_set_final_cache_size_relative_to_available_space}, q{thinlto_code_gen_t cg, uint percentage}},
			{q{void}, q{thinlto_codegen_set_cache_entry_expiration}, q{thinlto_code_gen_t cg, uint expiration}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 19){
		FnBind[] add = [
			{q{void}, q{thinlto_codegen_disable_codegen}, q{thinlto_code_gen_t cg, bool disable}},
			{q{void}, q{thinlto_codegen_set_codegen_only}, q{thinlto_code_gen_t cg, bool codegen_only}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 20){
		FnBind[] add = [
			{q{bool}, q{lto_module_has_objc_category}, q{const(void)* mem, size_t length}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 21){
		FnBind[] add = [
			{q{uint}, q{thinlto_module_get_num_object_files}, q{thinlto_code_gen_t cg}},
			{q{const(char)*}, q{thinlto_module_get_object_file}, q{thinlto_code_gen_t cg, uint index}},
			{q{void}, q{thinlto_set_generated_objects_dir}, q{thinlto_code_gen_t cg, const(char)* save_temps_dir}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 22){
		FnBind[] add = [
			{q{void}, q{thinlto_codegen_set_cache_size_bytes}, q{thinlto_code_gen_t cg, uint max_size_bytes}},
			{q{void}, q{thinlto_codegen_set_cache_size_files}, q{thinlto_code_gen_t cg, uint max_size_files}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 23){
		FnBind[] add = [
			{q{void}, q{thinlto_codegen_set_cache_size_megabytes}, q{thinlto_code_gen_t cg, uint max_size_megabytes}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 24){
		FnBind[] add = [
			{q{lto_input_t}, q{lto_input_create}, q{const(void)* buffer, size_t buffer_size, const(char)* path}},
			{q{void}, q{lto_input_dispose}, q{lto_input_t input}},
			{q{uint}, q{lto_input_get_num_dependent_libraries}, q{lto_input_t input}},
			{q{const(char)*}, q{lto_input_get_dependent_library}, q{lto_input_t input, size_t index, size_t* size}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 25){
		FnBind[] add = [
			{q{const(char*)*}, q{lto_runtime_lib_symbols_list}, q{size_t* size}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 26){
		FnBind[] add = [
			{q{void}, q{lto_codegen_debug_options_array}, q{lto_code_gen_t cg, const(char*)*, int number}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 27){
		FnBind[] add = [
			{q{bool}, q{lto_module_get_macho_cputype}, q{lto_module_t mod, uint* out_cputype, uint* out_cpusubtype}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 28){
		FnBind[] add = [
			{q{void}, q{lto_set_debug_options}, q{const(char*)* options, int number}},
		];
		ret ~= add;
	}
	if(LTO_API_VERSION >= 29){
		FnBind[] add = [
			{q{bool}, q{lto_module_has_ctor_dtor}, q{lto_module_t mod}},
		];
		ret ~= add;
	}
	return ret;
}()));
