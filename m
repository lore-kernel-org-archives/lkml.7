Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD77C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B19216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2nZgKzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfETVUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:20:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfETVUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FIExOJF0z6m6eKDwWBzs5DWjdKYFToe+a/7/EAJswPk=; b=S2nZgKzr/2SmlroEU2uwynzP7b
        pF2Ovch800QutKbd95Hj8T7t1yJUdqYIpbVjzbWNq9cOY5gSQqNmwmAbTE8R0twhk6FUcmYEa9hJZ
        bq6AjLyfP1zX9Cwnm0Lydvl4fsp2jqDPnRNp14xbsjurhLT/BhdSagWVUNaV5U1/X625YXB98WqhA
        Snc0RMkQqOzS6dyEjOXWEVD2ePfUEqrN8eONtC/fkXGVprjz1im9DK+5L81s85g1ayNhIZUiWeG2I
        HvD8kBKOuGO26JbH13liOGzQyRxn33OtUirDguWOcm2wdn2vd8cy38GY0cP0X1AAoa+H++s01zjkE
        r8+ggJ9Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSpi9-0004YN-24; Mon, 20 May 2019 21:20:45 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     George Spelvin <lkml@sdf.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] lib/sort.c: fix kernel-doc notation warnings
Message-ID: <60e25d3d-68d1-bde2-3b39-e4baa0b14907@infradead.org>
Date:   Mon, 20 May 2019 14:20:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc notation in lib/sort.c by using correct function
parameter names.

../lib/sort.c:59: warning: Excess function parameter 'size' description in 'swap_words_32'
../lib/sort.c:83: warning: Excess function parameter 'size' description in 'swap_words_64'
../lib/sort.c:110: warning: Excess function parameter 'size' description in 'swap_bytes'

Fixes: 37d0ec34d111a ("lib/sort: make swap functions more generic")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: George Spelvin <lkml@sdf.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
This patch still leaves these Sphinx warnings, which appears to be
some kind of "feature."  :(

../lib/list_sort.c:128: WARNING: Definition list ends without a blank line; unexpected unindent.
../lib/list_sort.c:161: WARNING: Unexpected indentation.
../lib/list_sort.c:162: WARNING: Block quote ends without a blank line; unexpected unindent.

 lib/sort.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- lnx-52-rc1.orig/lib/sort.c
+++ lnx-52-rc1/lib/sort.c
@@ -43,8 +43,9 @@ static bool is_aligned(const void *base,
 
 /**
  * swap_words_32 - swap two elements in 32-bit chunks
- * @a, @b: pointers to the elements
- * @size: element size (must be a multiple of 4)
+ * @a: pointer to the first element to swap
+ * @b: pointer to the second element to swap
+ * @n: element size (must be a multiple of 4)
  *
  * Exchange the two objects in memory.  This exploits base+index addressing,
  * which basically all CPUs have, to minimize loop overhead computations.
@@ -65,8 +66,9 @@ static void swap_words_32(void *a, void
 
 /**
  * swap_words_64 - swap two elements in 64-bit chunks
- * @a, @b: pointers to the elements
- * @size: element size (must be a multiple of 8)
+ * @a: pointer to the first element to swap
+ * @b: pointer to the second element to swap
+ * @n: element size (must be a multiple of 8)
  *
  * Exchange the two objects in memory.  This exploits base+index
  * addressing, which basically all CPUs have, to minimize loop overhead
@@ -100,8 +102,9 @@ static void swap_words_64(void *a, void
 
 /**
  * swap_bytes - swap two elements a byte at a time
- * @a, @b: pointers to the elements
- * @size: element size
+ * @a: pointer to the first element to swap
+ * @b: pointer to the second element to swap
+ * @n: element size
  *
  * This is the fallback if alignment doesn't allow using larger chunks.
  */


