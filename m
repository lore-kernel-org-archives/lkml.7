Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BB6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316032084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502780AbfJYLIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:08:44 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:36422 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438658AbfJYLIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:08:42 -0400
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id Hn8b2100g5USYZQ01n8bmC; Fri, 25 Oct 2019 13:08:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNxSN-0003rD-NR; Fri, 25 Oct 2019 13:08:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNvs4-0006Lj-Uv; Fri, 25 Oct 2019 11:27:00 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     patches@armlinux.org.uk, Russell King <rmk+kernel@arm.linux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: ARM_ERRATA_775420: Spelling s/date/data/
Date:   Fri, 25 Oct 2019 11:27:00 +0200
Message-Id: <20191025092700.24367-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caching dates is never a good idea ;-)

Fixes: 7253b85cc62d6ff8 ("ARM: 7541/1: Add ARM ERRATA 775420 workaround")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v2:
  - Add Reviewed-by,
  - Add Fixes.
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8a50efb559f35a2c..b7dbeb652cb1edd5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1020,7 +1020,7 @@ config ARM_ERRATA_775420
        depends on CPU_V7
        help
 	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
-	 r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
+	 r2p6,r2p8,r2p10,r3p0) erratum. In case a data cache maintenance
 	 operation aborts with MMU exception, it might cause the processor
 	 to deadlock. This workaround puts DSB before executing ISB if
 	 an abort may occur on cache maintenance.
-- 
2.17.1

