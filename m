Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDACC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B3820693
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfGUSJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 14:09:40 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:35600 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfGUSJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:09:39 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d45 with ME
        id fW9Y2000C4n7eLC03W9YaP; Sun, 21 Jul 2019 20:09:37 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 20:09:37 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, aryabinin@virtuozzo.com,
        wei.w.wang@intel.com, cai@lca.pw
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mm/page_poison: fix a typo in a comment
Date:   Sun, 21 Jul 2019 20:09:08 +0200
Message-Id: <20190721180908.6534-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/posioned/poisoned/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 mm/page_poison.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index 21d4f97cb49b..34b9181ee5d1 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -101,7 +101,7 @@ static void unpoison_page(struct page *page)
 	/*
 	 * Page poisoning when enabled poisons each and every page
 	 * that is freed to buddy. Thus no extra check is done to
-	 * see if a page was posioned.
+	 * see if a page was poisoned.
 	 */
 	check_poison_mem(addr, PAGE_SIZE);
 	kunmap_atomic(addr);
-- 
2.20.1

