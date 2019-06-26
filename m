Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB58C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925A621670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ohwjVenQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfFZNE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:04:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39221 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZNE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:04:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QD4qA44114662
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 06:04:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QD4qA44114662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561554293;
        bh=+s0u7aVGHVKAuL2mRa+TO0g52PQbU/sLVQya3nyFqBA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ohwjVenQ7tTqZZBCV8tTPke9zKqjjTY79khJ85nR5gf+3BK+8BGArK/c9hWoU4NMx
         +/L2LSDmIpGwiqgacYZRjaiNXs7OuqY04T6fzCOamaHqZG19zA5b84ILLLufW1LbmR
         PtATQaSmzRD1wyoofg7+E6uTyslez5KZhvSRSpWwW5kgVcQjFaxTHiJjvXZB3t49mg
         2yK5kgBeg3sLuLMiA2pWnb93BIzQkDG/yXs9q76Vhe/NKMji8KdN43fNyqA42XJFoB
         IE3emWEkZmK/bZ2GwLwdDRE6hlg/XzqwO+Z1J+aYFG3Ow2KwZ4z77wycBOu2fbILgF
         HZJmWeWfjPaTg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QD4pOZ4114659;
        Wed, 26 Jun 2019 06:04:51 -0700
Date:   Wed, 26 Jun 2019 06:04:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ferdinand Blomqvist <tipbot@zytor.com>
Message-ID: <tip-38cbae1434f8f7bbd8eaf24b29a385a4b88938fb@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        ferdinand.blomqvist@gmail.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, ferdinand.blomqvist@gmail.com, hpa@zytor.com
In-Reply-To: <20190620141039.9874-7-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-7-ferdinand.blomqvist@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rslib] rslib: Update documentation
Git-Commit-ID: 38cbae1434f8f7bbd8eaf24b29a385a4b88938fb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  38cbae1434f8f7bbd8eaf24b29a385a4b88938fb
Gitweb:     https://git.kernel.org/tip/38cbae1434f8f7bbd8eaf24b29a385a4b88938fb
Author:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
AuthorDate: Thu, 20 Jun 2019 17:10:38 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 14:55:47 +0200

rslib: Update documentation

The decoder returns the number of corrected symbols, not bits.
The caller provided syndrome must be in index form.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190620141039.9874-7-ferdinand.blomqvist@gmail.com

---
 lib/reed_solomon/reed_solomon.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index e5fdc8b9e856..bbc01bad3053 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -340,7 +340,8 @@ EXPORT_SYMBOL_GPL(encode_rs8);
  *  @data:	data field of a given type
  *  @par:	received parity data field
  *  @len:	data length
- *  @s:		syndrome data field (if NULL, syndrome is calculated)
+ *  @s: 	syndrome data field, must be in index form
+ *		(if NULL, syndrome is calculated)
  *  @no_eras:	number of erasures
  *  @eras_pos:	position of erasures, can be NULL
  *  @invmsk:	invert data mask (will be xored on data, not on parity!)
@@ -354,7 +355,8 @@ EXPORT_SYMBOL_GPL(encode_rs8);
  *  decoding, so the caller has to ensure that decoder invocations are
  *  serialized.
  *
- *  Returns the number of corrected bits or -EBADMSG for uncorrectable errors.
+ *  Returns the number of corrected symbols or -EBADMSG for uncorrectable
+ *  errors. The count includes errors in the parity.
  */
 int decode_rs8(struct rs_control *rsc, uint8_t *data, uint16_t *par, int len,
 	       uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk,
@@ -391,7 +393,8 @@ EXPORT_SYMBOL_GPL(encode_rs16);
  *  @data:	data field of a given type
  *  @par:	received parity data field
  *  @len:	data length
- *  @s:		syndrome data field (if NULL, syndrome is calculated)
+ *  @s: 	syndrome data field, must be in index form
+ *		(if NULL, syndrome is calculated)
  *  @no_eras:	number of erasures
  *  @eras_pos:	position of erasures, can be NULL
  *  @invmsk:	invert data mask (will be xored on data, not on parity!)
@@ -403,7 +406,8 @@ EXPORT_SYMBOL_GPL(encode_rs16);
  *  decoding, so the caller has to ensure that decoder invocations are
  *  serialized.
  *
- *  Returns the number of corrected bits or -EBADMSG for uncorrectable errors.
+ *  Returns the number of corrected symbols or -EBADMSG for uncorrectable
+ *  errors. The count includes errors in the parity.
  */
 int decode_rs16(struct rs_control *rsc, uint16_t *data, uint16_t *par, int len,
 		uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk,
