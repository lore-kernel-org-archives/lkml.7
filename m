Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D34BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BE520830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JktlbAV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDIK1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:27:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfDIK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ngKAf2VLahEPkZZf4+wTfe2NIgqO9NPE9cTwlAM2kDk=; b=JktlbAV4jAiqOWE37mzK1i7fv
        zfPjtgQU14YOipgbdEFQsq3kID7cJTTHz/MkmTUAvj0nCSgCWTHujQ8FFKVEud/vvkeGehdFbIUkX
        Tw3XQEiMn4fRnYw9vxXlUUvAv7dS/rexLhJr68VxsRH+mqo72UABsB/Jdg9v2IWieGnX/eS1iJLEw
        h36eIt95+thMCtksMC6HLzaahhtatnQuDvQxJQrnCRxeY/Hqugk3CxOqs9MLl38tmr7NlNKCJpcFc
        2ZqBVEXeqWTWYKnyvHvuvYr6ZllMv98DXMkVUmQW+ugTRe8AnvRODsSW+iUURbhGof6SgqxovGvfN
        yHESzUYxQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDnyF-00059v-Js; Tue, 09 Apr 2019 10:27:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nds32: remove __virt_to_bus and __bus_to_virt
Date:   Tue,  9 Apr 2019 12:26:54 +0200
Message-Id: <20190409102654.25845-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are not used anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/include/asm/memory.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/nds32/include/asm/memory.h b/arch/nds32/include/asm/memory.h
index 60efc726b56e..9d552ee39bdb 100644
--- a/arch/nds32/include/asm/memory.h
+++ b/arch/nds32/include/asm/memory.h
@@ -15,14 +15,6 @@
 #define PHYS_OFFSET     (0x0)
 #endif
 
-#ifndef __virt_to_bus
-#define __virt_to_bus	__virt_to_phys
-#endif
-
-#ifndef __bus_to_virt
-#define __bus_to_virt	__phys_to_virt
-#endif
-
 /*
  * TASK_SIZE - the maximum size of a user space task.
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
-- 
2.20.1

