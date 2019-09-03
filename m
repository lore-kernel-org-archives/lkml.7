Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDAB217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfICIdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:33:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59266 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICIdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:33:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54EJ-0002pb-Tg; Tue, 03 Sep 2019 10:32:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 724D31C0DDE;
        Tue,  3 Sep 2019 10:31:59 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:59 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove the unused set_memory_array_*() functions
Cc:     Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190826075558.8125-3-hch@lst.de>
References: <20190826075558.8125-3-hch@lst.de>
MIME-Version: 1.0
Message-ID: <156749951932.13282.8464509353434255681.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     a919198b97c85e093c81eaae0b4864206ec2fe02
Gitweb:        https://git.kernel.org/tip/a919198b97c85e093c81eaae0b4864206ec2fe02
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 26 Aug 2019 09:55:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:26:37 +02:00

x86/mm: Remove the unused set_memory_array_*() functions

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190826075558.8125-3-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/set_memory.h |  5 +--
 arch/x86/mm/pageattr.c            | 75 +------------------------------
 2 files changed, 80 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ae7b909..899ec9a 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -48,11 +48,6 @@ int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 int set_memory_np_noalias(unsigned long addr, int numpages);
 
-int set_memory_array_uc(unsigned long *addr, int addrinarray);
-int set_memory_array_wc(unsigned long *addr, int addrinarray);
-int set_memory_array_wt(unsigned long *addr, int addrinarray);
-int set_memory_array_wb(unsigned long *addr, int addrinarray);
-
 int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
 int set_pages_array_wt(struct page **pages, int addrinarray);
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 08a6f04..1f97a72 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1819,63 +1819,6 @@ int set_memory_uc(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_uc);
 
-static int _set_memory_array(unsigned long *addr, int numpages,
-		enum page_cache_mode new_type)
-{
-	enum page_cache_mode set_type;
-	int i, j;
-	int ret;
-
-	for (i = 0; i < numpages; i++) {
-		ret = reserve_memtype(__pa(addr[i]), __pa(addr[i]) + PAGE_SIZE,
-					new_type, NULL);
-		if (ret)
-			goto out_free;
-	}
-
-	/* If WC, set to UC- first and then WC */
-	set_type = (new_type == _PAGE_CACHE_MODE_WC) ?
-				_PAGE_CACHE_MODE_UC_MINUS : new_type;
-
-	ret = change_page_attr_set(addr, numpages,
-				   cachemode2pgprot(set_type), 1);
-
-	if (!ret && new_type == _PAGE_CACHE_MODE_WC)
-		ret = change_page_attr_set_clr(addr, numpages,
-					       cachemode2pgprot(
-						_PAGE_CACHE_MODE_WC),
-					       __pgprot(_PAGE_CACHE_MASK),
-					       0, CPA_ARRAY, NULL);
-	if (ret)
-		goto out_free;
-
-	return 0;
-
-out_free:
-	for (j = 0; j < i; j++)
-		free_memtype(__pa(addr[j]), __pa(addr[j]) + PAGE_SIZE);
-
-	return ret;
-}
-
-int set_memory_array_uc(unsigned long *addr, int numpages)
-{
-	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_UC_MINUS);
-}
-EXPORT_SYMBOL(set_memory_array_uc);
-
-int set_memory_array_wc(unsigned long *addr, int numpages)
-{
-	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_WC);
-}
-EXPORT_SYMBOL(set_memory_array_wc);
-
-int set_memory_array_wt(unsigned long *addr, int numpages)
-{
-	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_WT);
-}
-EXPORT_SYMBOL_GPL(set_memory_array_wt);
-
 int _set_memory_wc(unsigned long addr, int numpages)
 {
 	int ret;
@@ -1952,24 +1895,6 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
 
-int set_memory_array_wb(unsigned long *addr, int numpages)
-{
-	int i;
-	int ret;
-
-	/* WB cache mode is hard wired to all cache attribute bits being 0 */
-	ret = change_page_attr_clear(addr, numpages,
-				      __pgprot(_PAGE_CACHE_MASK), 1);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < numpages; i++)
-		free_memtype(__pa(addr[i]), __pa(addr[i]) + PAGE_SIZE);
-
-	return 0;
-}
-EXPORT_SYMBOL(set_memory_array_wb);
-
 int set_memory_x(unsigned long addr, int numpages)
 {
 	if (!(__supported_pte_mask & _PAGE_NX))
