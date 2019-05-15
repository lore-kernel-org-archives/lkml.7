Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1340BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD88520818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfEOUEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:04:31 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:54650 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEOUEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:04:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 4CEC81812B800;
        Wed, 15 May 2019 22:04:30 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] MAINTAINERS: Update UBI/UBIFS git tree location
Date:   Wed, 15 May 2019 22:04:23 +0200
Message-Id: <20190515200423.17809-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus asked to use kernel.org.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c38f21aee78..ba428cd613b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15879,7 +15879,7 @@ M:	Richard Weinberger <richard@nod.at>
 M:	Artem Bityutskiy <dedekind1@gmail.com>
 M:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-mtd@lists.infradead.org
-T:	git git://git.infradead.org/ubifs-2.6.git
+T:	git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
 S:	Supported
 F:	Documentation/filesystems/ubifs.txt
-- 
2.16.4

