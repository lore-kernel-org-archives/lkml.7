Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B39BC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F67321835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BW2yauUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfJHUnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:43:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfJHUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dLnpeex3KKFOsysPFCnugkF5/r74EsXAIKBPbaZtxDM=; b=BW2yauUxp3Wlwx/nriYdxhFvF
        uUJSui2vU6dupAyaCN+NfgjQCz0D+ObxuSkwVLmdkd1zEPnEMGXtmUnmQzYl6ardzXfz+3OeHgZQF
        IxZ81S5liZ/3s8QJGbXeY/QBfApoGLrtNQUyibhl2DXEcEfbbDgtF0L8u/c0dgbuuyCt2kaW1JNdR
        GVQnWbBvHOgNdXVcxs8m9R+xJHRlLWsLEenW9XntuaKoRTm6bhOlA4+5+eABPDSpbKs442A8FKPgh
        wC52dJfpncKwHUL9REbnd2yldTK0IMR1Bleq4aCiXUAupwFzGxTSVhve2HMC9uzWswA4yelOcH+vQ
        qn2SbkWrg==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHwKZ-0004Fv-CP; Tue, 08 Oct 2019 20:43:39 +0000
To:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] xarray.h: fix kernel-doc warning
Message-ID: <89ba2134-ce23-7c10-5ee1-ef83b35aa984@infradead.org>
Date:   Tue, 8 Oct 2019 13:43:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix (Sphinx) kernel-doc warning in <linux/xarray.h>:

../include/linux/xarray.h:232: WARNING: Unexpected indentation.

Fixes: a3e4d3f97ec8 ("XArray: Redesign xa_alloc API")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
# mainline

 include/linux/xarray.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20191008.orig/include/linux/xarray.h
+++ linux-next-20191008/include/linux/xarray.h
@@ -230,8 +230,8 @@ static inline int xa_err(void *entry)
  * This structure is used either directly or via the XA_LIMIT() macro
  * to communicate the range of IDs that are valid for allocation.
  * Two common ranges are predefined for you:
- *  * xa_limit_32b	- [0 - UINT_MAX]
- *  * xa_limit_31b	- [0 - INT_MAX]
+ * * xa_limit_32b	- [0 - UINT_MAX]
+ * * xa_limit_31b	- [0 - INT_MAX]
  */
 struct xa_limit {
 	u32 max;

