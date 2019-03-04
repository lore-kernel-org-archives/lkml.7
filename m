Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18048C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A243620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YaL1rIQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCDOdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:33:45 -0500
Received: from m12-11.163.com ([220.181.12.11]:35693 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfCDOdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=3LWsI8h0aTQQgxIcyp
        HoWOb4/Q3ZiET8w3wlDevJCSM=; b=YaL1rIQJGilBxR/IZPcM7q74Q70I9wxc6n
        WDn9nvisufAa+SGBEPbq6hvfqBuxYoeul3itgm/keGMHCRikJJoAIc9UQ6Pl9uyS
        qhRlJUdkmjGtzPOZrRSpUmCcXht1zBXz52G4FuIK0wA5WEgbnW5WZBd33kTZSGwJ
        68M1CGD50=
Received: from yangwei-T440.lan (unknown [118.116.19.146])
        by smtp7 (Coremail) with SMTP id C8CowADH24k_N31cf764AQ--.59372S3;
        Mon, 04 Mar 2019 22:33:36 +0800 (CST)
From:   Yang Wei <albin_yang@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     green.hu@gmail.com, deanbo422@gmail.com, f.fainelli@gmail.com,
        rppt@linux.vnet.ibm.com, akpm@linux-foundation.org,
        yang.wei9@zte.com.cn, albin_yang@163.com
Subject: [PATCH] nds32: fix semicolon code style issue
Date:   Mon,  4 Mar 2019 22:33:28 +0800
Message-Id: <1551710008-3283-1-git-send-email-albin_yang@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowADH24k_N31cf764AQ--.59372S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw4kKryxGF4xZr4ktF1UJrb_yoW8Xr18pr
        ZrAFn5JF4rXFyvkw4DJrs3X393AasY9FnrWr1Uua1rCF1Yqw1kXr1kK343Zryvvr4093yr
        W3WfXFyrXw1UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHCJQUUUUU=
X-Originating-IP: [118.116.19.146]
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/1tbiRQBtoll9pEDsowAAsF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Wei <yang.wei9@zte.com.cn>

Delete superfluous semicolons.

Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
---
 arch/nds32/kernel/cacheinfo.c | 2 +-
 arch/nds32/mm/init.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/kernel/cacheinfo.c b/arch/nds32/kernel/cacheinfo.c
index 0a7bc69..aab98e4 100644
--- a/arch/nds32/kernel/cacheinfo.c
+++ b/arch/nds32/kernel/cacheinfo.c
@@ -13,7 +13,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->level = level;
 	this_leaf->type = type;
 	this_leaf->coherency_line_size = CACHE_LINE_SIZE(cache_type);
-	this_leaf->number_of_sets = CACHE_SET(cache_type);;
+	this_leaf->number_of_sets = CACHE_SET(cache_type);
 	this_leaf->ways_of_associativity = CACHE_WAY(cache_type);
 	this_leaf->size = this_leaf->number_of_sets *
 	    this_leaf->coherency_line_size * this_leaf->ways_of_associativity;
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index 253f79f..e2eb4eb 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -264,7 +264,7 @@ void __set_fixmap(enum fixed_addresses idx,
 
 	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
 
-	pte = (pte_t *)&fixmap_pmd_p[pte_index(addr)];;
+	pte = (pte_t *)&fixmap_pmd_p[pte_index(addr)];
 
 	if (pgprot_val(flags)) {
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
-- 
2.7.4


