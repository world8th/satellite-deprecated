#ifndef _CONSTANTS_H
#define _CONSTANTS_H

    // control flow
    #extension GL_EXT_control_flow_attributes : enable

    // data format extensions
    #extension GL_AMD_gcn_shader : enable
    #extension GL_AMD_gpu_shader_half_float : enable
    #extension GL_ARB_gpu_shader_int64 : enable
    #extension GL_AMD_gpu_shader_int16 : enable

    // intrinsics extensions
    #extension GL_AMD_shader_trinary_minmax : enable
    
    // texture extensions
    #extension GL_AMD_texture_gather_bias_lod : enable
    #extension GL_AMD_shader_image_load_store_lod : enable
    #extension GL_EXT_shader_image_load_formatted : enable

    // subgroup operations
    #extension GL_KHR_shader_subgroup_basic            : enable
    #extension GL_KHR_shader_subgroup_vote             : enable
    #extension GL_KHR_shader_subgroup_arithmetic       : enable
    #extension GL_KHR_shader_subgroup_ballot           : enable
    #extension GL_KHR_shader_subgroup_shuffle          : enable
    #extension GL_KHR_shader_subgroup_shuffle_relative : enable
    #extension GL_KHR_shader_subgroup_clustered        : enable


// ray tracing options
//#define EXPERIMENTAL_DOF
#define SUNLIGHT_CAUSTICS false
#define REFRACTION_SKIP_SUN
#define DIRECT_LIGHT_ENABLED

// sampling options
//#define MOTION_BLUR
#ifndef SAMPLES_LOCK
#define SAMPLES_LOCK 1
#endif

// enable required GAPI extensions
#ifdef ENABLE_AMD_INSTRUCTION_SET
    #define ENABLE_AMD_INT16 // RX Vega broken support 16-bit integer buffers in Vulkan API 1.1.70
    #define ENABLE_AMD_INT16_CONDITION
    #define USE_16BIT_ADDRESS_SPACE
#endif

#ifndef ENABLE_AMD_INSTRUCTION_SET
#undef ENABLE_AMD_INT16 // not supported combination
#endif

#ifndef ENABLE_AMD_INT16
#undef ENABLE_AMD_INT16_CONDITION // required i16
#endif

#ifdef ENABLE_NVIDIA_INSTRUCTION_SET
#extension GL_NV_gpu_shader5 : enable // not supported by SPIRV
#endif

// Platform-oriented compute
#ifndef WORK_SIZE
#ifdef ENABLE_AMD_INSTRUCTION_SET
// 16 working threads, with 1-4 hyper-threaded SIMD in 16 lanes, and depends by hyper-threaded wide, working threads in local group will moved to another work-group (in general, independently works 4-16 work-threads/cores)
//#define WORK_SIZE 128
#define WORK_SIZE 64
#else
#define WORK_SIZE 64
#endif
#endif

#define LOCAL_SIZE_LAYOUT layout ( local_size_x = WORK_SIZE ) in

#endif
