Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F46ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C172053B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfJIPMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:12:01 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33853 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfJIPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:12:00 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIDd6-00021H-PU; Wed, 09 Oct 2019 16:11:56 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iIDd6-0007EY-AD; Wed, 09 Oct 2019 16:11:56 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: include <linux/huge_mm.h> for is_vma_temporary_stack
Date:   Wed,  9 Oct 2019 16:11:55 +0100
Message-Id: <20191009151155.27763-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/huge_mm.h> for the definition of
is_vma_temporary_stack to fix the following
sparse warning:

mm/rmap.c:1673:6: warning: symbol 'is_vma_temporary_stack' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/rmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index d9a23bb773bf..0c7b2a9400d4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -61,6 +61,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/migrate.h>
 #include <linux/hugetlb.h>
+#include <linux/huge_mm.h>
 #include <linux/backing-dev.h>
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
-- 
2.23.0

