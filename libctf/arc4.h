#ifndef __ARC4_H__
#define __ARC4_H__

#include <stdint.h>
#include <stdlib.h>

#define ARC4_HASHLEN 16

struct arc4_ctx {
  uint8_t S[256];
  uint8_t i;
  uint8_t j;
};

void arc4_init(struct arc4_ctx *ctx, const uint8_t *key, size_t keylen);
uint8_t arc4_out(struct arc4_ctx *ctx);
void arc4_crypt(struct arc4_ctx *ctx,
                uint8_t *obuf, const uint8_t *ibuf, size_t buflen);
void arc4_crypt_buffer(const uint8_t *key, size_t keylen,
                       uint8_t *buf, size_t buflen);
#endif
