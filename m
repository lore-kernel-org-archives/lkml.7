Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D314C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580D22085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfFYHER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:04:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56198 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfFYHEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:04:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A357200019;
        Tue, 25 Jun 2019 09:04:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BD29E2006D7;
        Tue, 25 Jun 2019 09:04:06 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6CAD6402FB;
        Tue, 25 Jun 2019 15:03:58 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, ping.bai@nxp.com, peng.fan@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] clk: imx8mm: GPT1 clock mux option #5 should be sys_pll1_80m
Date:   Tue, 25 Jun 2019 15:06:02 +0800
Message-Id: <20190625070602.37670-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625070602.37670-1-Anson.Huang@nxp.com>
References: <20190625070602.37670-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX8MM's GPT1 clock mux option #5 should be sys_pll1_80m,
NOT sys_pll1_800m, correct it.

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

