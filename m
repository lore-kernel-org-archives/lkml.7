Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2BAC48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931872133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfFZB0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:26:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50886 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfFZB0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:26:16 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D0EC81A0916;
        Wed, 26 Jun 2019 03:26:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 31FF21A0F96;
        Wed, 26 Jun 2019 03:26:07 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4A463402D5;
        Wed, 26 Jun 2019 09:25:59 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, ping.bai@nxp.com, peng.fan@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH RESEND 2/2] clk: imx8mm: GPT1 clock mux option #5 should be sys_pll1_80m
Date:   Wed, 26 Jun 2019 09:28:03 +0800
Message-Id: <20190626012803.45627-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626012803.45627-1-Anson.Huang@nxp.com>
References: <20190626012803.45627-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX8MM's GPT1 clock mux option #5 should be sys_pll1_80m,
NOT sys_pll1_800m, correct it.

Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 516e68d..d1a84f7 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -293,7 +293,7 @@ static const char *imx8mm_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_1
 					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll1_out", };
 
 static const char *imx8mm_gpt1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m", "sys_pll1_40m",
-					 "video_pll1_out", "sys_pll1_800m", "audio_pll1_out", "clk_ext1" };
+					 "video_pll1_out", "sys_pll1_80m", "audio_pll1_out", "clk_ext1" };
 
 static const char *imx8mm_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m", "vpu_pll_out",
 					 "sys_pll2_125m", "sys_pll3_out", "sys_pll1_80m", "sys_pll2_166m", };
-- 
2.7.4

