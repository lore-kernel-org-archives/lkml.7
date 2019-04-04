Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0254FC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C735B206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="aToAwocn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfDDHYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:24:04 -0400
Received: from owa.iluvatar.ai ([103.91.158.24]:5254 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726058AbfDDHYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:24:04 -0400
X-AuditID: 0a650161-773ff700000078a3-3a-5ca5b10f9ea3
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id E2.73.30883.F01B5AC5; Thu,  4 Apr 2019 15:23:59 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1554362639; h=from:subject:to:date:message-id;
        bh=xx8VzHLiibMcDula0s0X91k44Awqbt6B1nRWsay/e1I=;
        b=aToAwocnWLp6XN3hzTRRF7P4iGhB++m9K7y0l7+EMVvqrTgOUWvR9VtHyviIauiOyQm0dDC+4rk
        yaZJUnW93dnWEu4d3Rhi5/AnTCgRFNXB0zMu2xLk48h9iFvxYD9cr3NQ6+Iy3oNM0vwPgblRQfYO6
        yDdzj+jMmBTil8ykwho=
Received: from hsj-Precision-5520.iluvatar.local (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Thu, 4 Apr 2019 15:23:59 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <akpm@linux-foundation.org>
CC:     <ira.weiny@intel.com>, <sfr@canb.auug.org.au>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH] mm/gup.c: fix the wrong comments
Date:   Thu, 4 Apr 2019 15:23:47 +0800
Message-ID: <20190404072347.3440-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsXClcqYpsu/cWmMweweHYs569ewWex/+pzF
        4vKuOWwW99b8Z7XYuvcquwOrR+ONG2wei/e8ZPLY9GkSu8eJGb9ZPD5vkgtgjeKySUnNySxL
        LdK3S+DK2Nu4hLlgOV/FttYvrA2Mq7m7GDk5JARMJH70/GTqYuTiEBI4wSgx4d8CRpAEs4CE
        xMEXL5hBbBaBt0wSx+Z4QxS1Mkm0PVjEBJJgE9CQmHviLliRiIC8RNOXR+wgRcwCvYwS9xqm
        gRUJCxhK7Fz1n62LkQNokorEnaNiIGFeAXOJG+0vWSGukJdYveEAM0RcUOLkzCcsIOVCAgoS
        L1ZqQZQoSSzZO4sJwi6U+P7yLssERoFZSE6dhaR7ASPTKkb+4tx0vcyc0rLEksQivcTMTYyQ
        YE3cwXij86XeIUYBDkYlHt4fq5fECLEmlhVX5h5ilOBgVhLhdX0NFOJNSaysSi3Kjy8qzUkt
        PsQozcGiJM5bNtEkRkggPbEkNTs1tSC1CCbLxMEp1cCksJnNyiHsLO8EfgfPOK77U2wTDJ+x
        tJ3bV7j/4ea9Hms7TQITbwWc0nKSulCw6Se/Q5LvwZx/y6zlVO7OW7546yrjddtr1Q6/fWAv
        +vy6i4rLi0tSay+qHVhk8mDu3bYX8aEJGWdtvzGs5zL+usg/stV4Rnf2zzPyJxtNa+YWKAqY
        siQ86P562pM5Mn7NevcpecuinMvlp3wXrtP5H/Zo6kVjuevuZ65efpL/R3q/4ryLx1kmfpM3
        5y0S/X/0zr0ZUoaSSdvS/Axfh5/embH87YYioXitas+9fy8K/LD245lmzsxdIK2ovLJkk8uf
        m4lahgfCm9n4RTMEtGfPtjdXk4iaI6LxNev/QibXV6eVWIozEg21mIuKEwEEoaWG0wIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HAVE_GENERIC_GUP is defined, the kernel will use its own
get_user_pages_fast().

In the following scenario, we will may meet the bug in the DMA case:
	    .....................
	    get_user_pages_fast(start,,, pages);
	        ......
	    sg_alloc_table_from_pages(, pages, ...);
	    .....................

The root cause is that sg_alloc_table_from_pages() requires the
page order to keep the same as it used in the user space, but
get_user_pages_fast() will mess it up.

So change the comments, and make it more clear for the driver
users.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 mm/gup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 22acdd0f79ff..b810d15d4db9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1129,10 +1129,6 @@ EXPORT_SYMBOL(get_user_pages_locked);
  *  with:
  *
  *      get_user_pages_unlocked(tsk, mm, ..., pages);
- *
- * It is functionally equivalent to get_user_pages_fast so
- * get_user_pages_fast should be used instead if specific gup_flags
- * (e.g. FOLL_FORCE) are not required.
  */
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 			     struct page **pages, unsigned int gup_flags)
@@ -2147,6 +2143,10 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
  * If not successful, it will fall back to taking the lock and
  * calling get_user_pages().
  *
+ * This function is different from the get_user_pages_unlocked():
+ *      The @pages may has different page order with the result
+ *      got by get_user_pages_unlocked().
+ *
  * Returns number of pages pinned. This may be fewer than the number
  * requested. If nr_pages is 0 or negative, returns 0. If no pages
  * were pinned, returns -errno.
-- 
2.17.1

