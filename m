Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CB6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90A922DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfH1NeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:34:20 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:36198 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1NeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:34:19 -0400
Received: from ramsan ([84.194.98.4])
        by michel.telenet-ops.be with bizsmtp
        id udaG2000B05gfCL06daGz1; Wed, 28 Aug 2019 15:34:17 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i2y5Y-0000C4-7e; Wed, 28 Aug 2019 15:34:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i2y5Y-0005Ru-62; Wed, 28 Aug 2019 15:34:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     chenhui zhao <chenhui.zhao@freescale.com>,
        Scott Wood <oss@buserror.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] powerpc/booke: Spelling s/date/data/
Date:   Wed, 28 Aug 2019 15:34:15 +0200
Message-Id: <20190828133415.20903-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caching dates is never a good idea ;-)

Fixes: e7affb1dba0e9068 ("powerpc/cache: add cache flush operation for various e500")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 2b4f3ec0acf7d988..1d308780e0d31eb9 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -231,7 +231,7 @@ _GLOBAL(__setup_cpu_e5500)
 	blr
 #endif
 
-/* flush L1 date cache, it can apply to e500v2, e500mc and e5500 */
+/* flush L1 data cache, it can apply to e500v2, e500mc and e5500 */
 _GLOBAL(flush_dcache_L1)
 	mfmsr	r10
 	wrteei	0
-- 
2.17.1

