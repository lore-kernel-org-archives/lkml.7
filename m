Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04499C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED0A20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfC1X6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:58:36 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:60206 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728587AbfC1X6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:58:32 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x2SNSAxk000523;
        Fri, 29 Mar 2019 01:28:10 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id EA27E63000; Fri, 29 Mar 2019 01:58:06 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     joe@perches.com, avifishman70@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        brendanhiggins@google.com, tali.perry1@gmail.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 2/2] MAINTAINERS: Add maintainer and replacing reviewer ARM/NUVOTON NPCM
Date:   Fri, 29 Mar 2019 01:57:52 +0200
Message-Id: <20190328235752.334462-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190328235752.334462-1-tmaimon77@gmail.com>
References: <20190328235752.334462-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Tali Perry as Nuvoton NPCM maintainer
Replacing Brendan Higgins Nuvoton NPCM reviewer with
Benjamin Fair.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b305d2f2a8a..4ece87fcc166 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1893,9 +1893,10 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
 ARM/NUVOTON NPCM ARCHITECTURE
 M:	Avi Fishman <avifishman70@gmail.com>
 M:	Tomer Maimon <tmaimon77@gmail.com>
+M:	Tali Perry <tali.perry1@gmail.com>
 R:	Patrick Venture <venture@google.com>
 R:	Nancy Yuen <yuenn@google.com>
-R:	Brendan Higgins <brendanhiggins@google.com>
+R:	Benjamin Fair <benjaminfair@google.com>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/arm/mach-npcm/
-- 
2.14.1

