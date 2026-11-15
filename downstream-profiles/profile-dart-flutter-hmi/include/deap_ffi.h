/*
 * DEAP Ring-2 Foreign Function Interface C11 / C++ Header (`deap_ffi.h`)
 *
 * Profile: DEAP-PROFILE-DART-FFI-001 (`downstream-profiles/profile-dart-flutter-hmi/`)
 * Library: `libdeap_ffi.dylib` / `libdeap_ffi.so` / `libdeap_ffi.a` (`#![forbid(unsafe_code)]`)
 * Guarantees: Fixed 4096-byte descriptors, zero raw pointer arithmetic, `catch_unwind` firewall.
 */

#ifndef DEAP_FFI_H
#define DEAP_FFI_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define DEAP_FFI_MAX_SLICE_BYTES 4096U
#define DEAP_FFI_STAGE_COUNT 5U

#define DEAP_STAGE_INGEST_SYSML 0U
#define DEAP_STAGE_ASSEMBLE_CONOPS 1U
#define DEAP_STAGE_COMPILE_SYSML 2U
#define DEAP_STAGE_RECONCILE_BACKLOG 3U
#define DEAP_STAGE_VERIFY_BASELINE 4U

typedef enum FfiStatus {
    DEAP_FFI_STATUS_OK = 0,
    DEAP_FFI_STATUS_EMPTY_SLICE = 1,
    DEAP_FFI_STATUS_OVERSIZED_SLICE = 2,
    DEAP_FFI_STATUS_INVALID_UTF8 = 3,
    DEAP_FFI_STATUS_FORBIDDEN_CONTROL_BYTE = 4,
    DEAP_FFI_STATUS_NON_NFC_INPUT = 5,
    DEAP_FFI_STATUS_INVALID_PATH = 6,
    DEAP_FFI_STATUS_NON_FINITE_SCALAR = 7,
    DEAP_FFI_STATUS_ISQ_FAULT = 8,
    DEAP_FFI_STATUS_INVALID_DOMAIN_TAG = 9,
    DEAP_FFI_STATUS_CRC_MISMATCH = 10,
    DEAP_FFI_STATUS_NULL_CALLBACK = 11,
    DEAP_FFI_STATUS_SIGNATURE_INVALID = 12,
    DEAP_FFI_STATUS_DIGEST_MISMATCH = 13,
    DEAP_FFI_STATUS_STAGE_EXEC_FAILED = 14,
    DEAP_FFI_STATUS_PANIC_CONTAINED = 255
} FfiStatus;

typedef struct FfiSliceDesc {
    uint8_t bytes[DEAP_FFI_MAX_SLICE_BYTES];
    size_t offset;
    size_t len;
} FfiSliceDesc;

typedef struct FfiFixedBuffer {
    uint8_t bytes[DEAP_FFI_MAX_SLICE_BYTES];
    size_t written_len;
} FfiFixedBuffer;

typedef struct FfiSanitizeOut {
    uint32_t byte_len;
    uint16_t diag_code;
    uint8_t exit_code;
    uint8_t reserved;
} FfiSanitizeOut;

typedef struct FfiDigestOut {
    uint8_t bytes[32];
} FfiDigestOut;

typedef struct FfiCrc32cOut {
    uint32_t crc32c;
    uint32_t payload_len;
} FfiCrc32cOut;

typedef struct FfiQuantityDesc {
    uint64_t value_bits;
    int16_t dim[7];
    uint16_t isq_fault_code;
} FfiQuantityDesc;

typedef FfiStatus (*FfiUnwindProbe)(uint64_t token);

FfiStatus deap_ffi_invoke_guarded(FfiUnwindProbe probe, uint64_t token);

FfiStatus deap_ffi_sanitize_utf8(
    const FfiSliceDesc *input,
    bool strict_nfc_lf,
    FfiFixedBuffer *out_buf,
    FfiSanitizeOut *out_meta
);

FfiStatus deap_ffi_normalize_rel_path(
    const FfiSliceDesc *input,
    FfiFixedBuffer *out_buf,
    FfiSanitizeOut *out_meta
);

FfiStatus deap_ffi_sha256(
    const FfiSliceDesc *input,
    bool allow_empty,
    FfiDigestOut *out_digest
);

FfiStatus deap_ffi_tagged_sha256(
    uint8_t domain_byte,
    const FfiSliceDesc *input,
    bool allow_empty,
    FfiDigestOut *out_digest
);

FfiStatus deap_ffi_crc32c_compute(
    const FfiSliceDesc *input,
    bool allow_empty,
    FfiCrc32cOut *out_crc
);

FfiStatus deap_ffi_crc32c_verify_trailer(
    const FfiSliceDesc *frame,
    FfiFixedBuffer *out_buf,
    FfiCrc32cOut *out_crc
);

FfiStatus deap_ffi_can_f64_canonicalize(uint64_t raw_bits, uint64_t *out_bits);

FfiStatus deap_ffi_quantity_checked_add(
    const FfiQuantityDesc *lhs,
    const FfiQuantityDesc *rhs,
    FfiQuantityDesc *out_qty
);

FfiStatus deap_ffi_quantity_checked_mul(
    const FfiQuantityDesc *lhs,
    const FfiQuantityDesc *rhs,
    FfiQuantityDesc *out_qty
);

FfiStatus deap_ffi_quantity_coherent_check(
    const FfiQuantityDesc *qty,
    uint64_t scale_alpha_bits,
    uint64_t offset_beta_bits,
    FfiQuantityDesc *out_qty
);

FfiStatus deap_ffi_verify_bundle(
    const FfiSliceDesc *manifest_json,
    const FfiSliceDesc *bundle_dir,
    const FfiSliceDesc *target_triple,
    const FfiSliceDesc *verify_key_hex,
    FfiSanitizeOut *out_meta
);

FfiStatus deap_ffi_run_stage(
    const FfiSliceDesc *workspace_dir,
    uint8_t stage_id,
    const FfiSliceDesc *extra_args_nl,
    FfiFixedBuffer *out_buf,
    FfiSanitizeOut *out_meta
);

#ifdef __cplusplus
}
#endif

#endif /* DEAP_FFI_H */
