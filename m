Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AC6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAF720862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfENPeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:34:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:38775 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbfENPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:34:00 -0400
X-IronPort-AV: E=Sophos;i="5.60,469,1549897200"; 
   d="scan'208";a="15714500"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 May 2019 00:33:58 +0900
Received: from renesas-ubuntu18.ree.adwin.renesas.com (unknown [10.226.36.106])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E356940123F7;
        Wed, 15 May 2019 00:33:56 +0900 (JST)
From:   Chris Paterson <chris.paterson2@renesas.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Biju Das <biju.das@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH] scripts/spelling.txt: Add spelling fix for prohibited
Date:   Tue, 14 May 2019 16:33:41 +0100
Message-Id: <20190514153341.22540-1-chris.paterson2@renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misspelling 'prohibited' is quite common in the real world, although
surprisingly not so much in the Linux Kernel. In addition to fixing the
typo we may as well add it to the spelling checker.

Also adding the present participle (prohibiting).

Fixes: 5bf2fbbef50c ("clk: renesas: cpg-mssr: Add r8a77470 support")

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 drivers/clk/renesas/r8a77470-cpg-mssr.c | 2 +-
 scripts/spelling.txt                    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a77470-cpg-mssr.c b/drivers/clk/renesas/r8a77470-cpg-mssr.c
index ab0fb10b6bf0..d81ae65f0d18 100644
--- a/drivers/clk/renesas/r8a77470-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77470-cpg-mssr.c
@@ -175,7 +175,7 @@ static const unsigned int r8a77470_crit_mod_clks[] __initconst = {
  *---------------------------------------------------
  * 0  0		20		x80	x78	x50
  * 0  1		26		x60	x60	x56
- * 1  0		Prohibitted setting
+ * 1  0		Prohibited setting
  * 1  1		30		x52	x52	x50
  *
  * *1 :	Table 7.4 indicates VCO output (PLL0 = VCO)
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index dcd25a31f9f5..135459f59db6 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1310,6 +1310,8 @@ programmble||programmable
 programm||program
 programms||programs
 progresss||progress
+prohibitted||prohibited
+prohibitting||prohibiting
 promiscouos||promiscuous
 promiscous||promiscuous
 promixity||proximity
-- 
2.17.1

