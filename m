Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EE8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE54218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfCUCYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:24:45 -0400
Received: from clyde.resnet.cms.waikato.ac.nz ([130.217.221.53]:33476 "EHLO
        clyde.resnet.cms.waikato.ac.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbfCUCYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:24:44 -0400
X-Greylist: delayed 2080 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 22:24:44 EDT
Received: from tom by clyde.resnet.cms.waikato.ac.nz with local (Exim 4.89)
        (envelope-from <tom@clyde.resnet.cms.waikato.ac.nz>)
        id 1h6mqH-0003Wa-1E; Thu, 21 Mar 2019 14:50:01 +1300
From:   Tom Levy <tomlevy93@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <trivial@kernel.org>,
        Tom Levy <tomlevy93@gmail.com>
Subject: [PATCH] lz4: fix spelling and copy-paste errors in documentation
Date:   Thu, 21 Mar 2019 14:44:52 +1300
Message-Id: <20190321014452.13297-1-tomlevy93@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few spelling and grammar errors, and two places where fast/safe
in the documentation did not match the function.

Signed-off-by: Tom Levy <tomlevy93@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/lz4.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/lz4.h b/include/linux/lz4.h
index 394e3d9213b8..b16e15b9587a 100644
--- a/include/linux/lz4.h
+++ b/include/linux/lz4.h
@@ -278,7 +278,7 @@ int LZ4_decompress_fast(const char *source, char *dest, int originalSize);
  * @compressedSize: is the precise full size of the compressed block
  * @maxDecompressedSize: is the size of 'dest' buffer
  *
- * Decompresses data fom 'source' into 'dest'.
+ * Decompresses data from 'source' into 'dest'.
  * If the source stream is detected malformed, the function will
  * stop decoding and return a negative result.
  * This function is protected against buffer overflow exploits,
@@ -522,7 +522,7 @@ int LZ4_setStreamDecode(LZ4_streamDecode_t *LZ4_streamDecode,
 	const char *dictionary, int dictSize);
 
 /**
- * LZ4_decompress_fast_continue() - Decompress blocks in streaming mode
+ * LZ4_decompress_safe_continue() - Decompress blocks in streaming mode
  * @LZ4_streamDecode: the 'LZ4_streamDecode_t' structure
  * @source: source address of the compressed data
  * @dest: output buffer address of the uncompressed data
@@ -530,7 +530,7 @@ int LZ4_setStreamDecode(LZ4_streamDecode_t *LZ4_streamDecode,
  * @compressedSize: is the precise full size of the compressed block
  * @maxDecompressedSize: is the size of 'dest' buffer
  *
- * These decoding function allows decompression of multiple blocks
+ * This decoding function allows decompression of multiple blocks
  * in "streaming" mode.
  * Previously decoded blocks *must* remain available at the memory position
  * where they were decoded (up to 64 KB)
@@ -569,7 +569,7 @@ int LZ4_decompress_safe_continue(LZ4_streamDecode_t *LZ4_streamDecode,
  *	which must be already allocated with 'originalSize' bytes
  * @originalSize: is the original and therefore uncompressed size
  *
- * These decoding function allows decompression of multiple blocks
+ * This decoding function allows decompression of multiple blocks
  * in "streaming" mode.
  * Previously decoded blocks *must* remain available at the memory position
  * where they were decoded (up to 64 KB)
@@ -610,10 +610,10 @@ int LZ4_decompress_fast_continue(LZ4_streamDecode_t *LZ4_streamDecode,
  * @dictStart: pointer to the start of the dictionary in memory
  * @dictSize: size of dictionary
  *
- * These decoding function works the same as
+ * This decoding function works the same as
  * a combination of LZ4_setStreamDecode() followed by
  * LZ4_decompress_safe_continue()
- * It is stand-alone, and don'tn eed a LZ4_streamDecode_t structure.
+ * It is stand-alone, and doesn't need an LZ4_streamDecode_t structure.
  *
  * Return: number of bytes decompressed into destination buffer
  *	(necessarily <= maxDecompressedSize)
@@ -633,10 +633,10 @@ int LZ4_decompress_safe_usingDict(const char *source, char *dest,
  * @dictStart: pointer to the start of the dictionary in memory
  * @dictSize: size of dictionary
  *
- * These decoding function works the same as
+ * This decoding function works the same as
  * a combination of LZ4_setStreamDecode() followed by
- * LZ4_decompress_safe_continue()
- * It is stand-alone, and don'tn eed a LZ4_streamDecode_t structure.
+ * LZ4_decompress_fast_continue()
+ * It is stand-alone, and doesn't need an LZ4_streamDecode_t structure.
  *
  * Return: number of bytes decompressed into destination buffer
  *	(necessarily <= maxDecompressedSize)
-- 
2.11.0

