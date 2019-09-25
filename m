Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EBEC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9922D21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436953AbfIYOQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:16:43 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50763 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730549AbfIYOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:16:42 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iD85q-0000Eu-DC; Wed, 25 Sep 2019 15:16:34 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iD85p-00066k-Mm; Wed, 25 Sep 2019 15:16:33 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/5] clk: hisilicon: fix sparse warnings in clk-hi3670.c
Date:   Wed, 25 Sep 2019 15:16:28 +0100
Message-Id: <20190925141632.23434-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings from sparse by removing the 0 initialiser
that is actually a pointer.

drivers/clk/hisilicon/clk-hi3670.c:298:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:300:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:302:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:304:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:306:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:308:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:310:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:312:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:314:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:316:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:318:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:320:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:322:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:324:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:326:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:328:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:330:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:332:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:334:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:336:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:338:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:340:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:342:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:344:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:346:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:348:65: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:350:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:352:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:488:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:490:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:492:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:494:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:496:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:498:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:500:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:502:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:504:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:506:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:508:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:510:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:512:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:514:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:516:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:518:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:520:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:522:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:524:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:526:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:528:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:530:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:532:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:534:71: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:536:71: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:538:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:611:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:614:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:616:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:653:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:655:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:657:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:659:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:661:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:663:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:665:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:735:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:737:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:739:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:741:63: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:743:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:745:64: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:802:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:804:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:806:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:808:69: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:810:70: warning: Using plain integer as NULL pointer
drivers/clk/hisilicon/clk-hi3670.c:812:69: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/clk/hisilicon/clk-hi3670.c | 152 ++++++++++++++---------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3670.c b/drivers/clk/hisilicon/clk-hi3670.c
index fd8c837a6ea3..4d05a71683a5 100644
--- a/drivers/clk/hisilicon/clk-hi3670.c
+++ b/drivers/clk/hisilicon/clk-hi3670.c
@@ -295,61 +295,61 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 
 static const struct hisi_gate_clock hi3670_crgctrl_gate_clks[] = {
 	{ HI3670_AUTODIV_SYSBUS, "autodiv_sysbus", "clk_div_sysbus",
-	  CLK_SET_RATE_PARENT, 0x404, 5, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x404, 5, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_AUTODIV_EMMC0BUS, "autodiv_emmc0bus", "autodiv_sysbus",
-	  CLK_SET_RATE_PARENT, 0x404, 1, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x404, 1, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_PCLK_ANDGT_MMC1_PCIE, "pclk_andgt_mmc1_pcie", "clk_div_320m",
-	  CLK_SET_RATE_PARENT, 0xf8, 13, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xf8, 13, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_GATE_VCODECBUS_GT, "clk_gate_vcodecbus_gt", "clk_mux_vcodecbus",
-	  CLK_SET_RATE_PARENT, 0x0F0, 8, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x0F0, 8, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_SD, "clk_andgt_sd", "clk_mux_sd_pll",
-	  CLK_SET_RATE_PARENT, 0xF4, 3, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 3, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_SD_SYS_GT, "clk_sd_sys_gt", "clkin_sys",
-	  CLK_SET_RATE_PARENT, 0xF4, 5, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 5, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_SDIO, "clk_andgt_sdio", "clk_mux_sdio_pll",
-	  CLK_SET_RATE_PARENT, 0xF4, 8, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 8, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_SDIO_SYS_GT, "clk_sdio_sys_gt", "clkin_sys",
-	  CLK_SET_RATE_PARENT, 0xF4, 6, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 6, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_A53HPM_ANDGT, "clk_a53hpm_andgt", "clk_mux_a53hpm",
-	  CLK_SET_RATE_PARENT, 0x0F4, 7, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x0F4, 7, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_320M_PLL_GT, "clk_320m_pll_gt", "clk_mux_320m",
-	  CLK_SET_RATE_PARENT, 0xF8, 10, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF8, 10, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_UARTH, "clk_andgt_uarth", "clk_div_320m",
-	  CLK_SET_RATE_PARENT, 0xF4, 11, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 11, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_UARTL, "clk_andgt_uartl", "clk_div_320m",
-	  CLK_SET_RATE_PARENT, 0xF4, 10, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 10, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_UART0, "clk_andgt_uart0", "clk_div_320m",
-	  CLK_SET_RATE_PARENT, 0xF4, 9, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 9, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_SPI, "clk_andgt_spi", "clk_div_320m",
-	  CLK_SET_RATE_PARENT, 0xF4, 13, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 13, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_PCIEAXI, "clk_andgt_pcieaxi", "clk_mux_pcieaxi",
-	  CLK_SET_RATE_PARENT, 0xfc, 15, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xfc, 15, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_AO_ASP_GT, "clk_div_ao_asp_gt", "clk_mux_ao_asp",
-	  CLK_SET_RATE_PARENT, 0xF4, 4, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 4, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_GATE_CSI_TRANS, "clk_gate_csi_trans", "clk_ppll2",
-	  CLK_SET_RATE_PARENT, 0xF4, 14, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 14, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_GATE_DSI_TRANS, "clk_gate_dsi_trans", "clk_ppll2",
-	  CLK_SET_RATE_PARENT, 0xF4, 1, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF4, 1, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_PTP, "clk_andgt_ptp", "clk_div_320m",
-	  CLK_SET_RATE_PARENT, 0xF8, 5, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF8, 5, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_OUT0, "clk_andgt_out0", "clk_ppll0",
-	  CLK_SET_RATE_PARENT, 0xF0, 10, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF0, 10, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_OUT1, "clk_andgt_out1", "clk_ppll0",
-	  CLK_SET_RATE_PARENT, 0xF0, 11, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF0, 11, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLKGT_DP_AUDIO_PLL_AO, "clkgt_dp_audio_pll_ao", "clk_ppll6",
-	  CLK_SET_RATE_PARENT, 0xF8, 15, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF8, 15, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_VDEC, "clk_andgt_vdec", "clk_mux_vdec",
-	  CLK_SET_RATE_PARENT, 0xF0, 13, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF0, 13, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_VENC, "clk_andgt_venc", "clk_mux_venc",
-	  CLK_SET_RATE_PARENT, 0xF0, 9, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xF0, 9, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ISP_SNCLK_ANGT, "clk_isp_snclk_angt", "clk_div_a53hpm",
-	  CLK_SET_RATE_PARENT, 0x108, 2, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x108, 2, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_RXDPHY, "clk_andgt_rxdphy", "clk_div_a53hpm",
-	  CLK_SET_RATE_PARENT, 0x0F0, 12, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x0F0, 12, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_ICS, "clk_andgt_ics", "clk_mux_ics",
-	  CLK_SET_RATE_PARENT, 0xf0, 14, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xf0, 14, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_AUTODIV_DMABUS, "autodiv_dmabus", "autodiv_sysbus",
-	  CLK_SET_RATE_PARENT, 0x404, 3, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x404, 3, CLK_GATE_HIWORD_MASK, },
 };
 
 static const char *const
@@ -485,57 +485,57 @@ static const struct hisi_mux_clock hi3670_crgctrl_mux_clks[] = {
 
 static const struct hisi_divider_clock hi3670_crgctrl_divider_clks[] = {
 	{ HI3670_CLK_DIV_CFGBUS, "clk_div_cfgbus", "clk_div_sysbus",
-	  CLK_SET_RATE_PARENT, 0xEC, 0, 2, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xEC, 0, 2, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_MMC0BUS, "clk_div_mmc0bus", "autodiv_emmc0bus",
-	  CLK_SET_RATE_PARENT, 0x0EC, 2, 1, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x0EC, 2, 1, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_MMC1BUS, "clk_div_mmc1bus", "clk_div_sysbus",
-	  CLK_SET_RATE_PARENT, 0x0EC, 3, 1, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x0EC, 3, 1, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_PCLK_DIV_MMC1_PCIE, "pclk_div_mmc1_pcie", "pclk_andgt_mmc1_pcie",
-	  CLK_SET_RATE_PARENT, 0xb4, 6, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xb4, 6, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_VCODECBUS, "clk_div_vcodecbus", "clk_gate_vcodecbus_gt",
-	  CLK_SET_RATE_PARENT, 0x0BC, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x0BC, 0, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_SD, "clk_div_sd", "clk_andgt_sd",
-	  CLK_SET_RATE_PARENT, 0xB8, 0, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xB8, 0, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_SDIO, "clk_div_sdio", "clk_andgt_sdio",
-	  CLK_SET_RATE_PARENT, 0xC0, 0, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xC0, 0, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_UARTH, "clk_div_uarth", "clk_andgt_uarth",
-	  CLK_SET_RATE_PARENT, 0xB0, 12, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xB0, 12, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_UARTL, "clk_div_uartl", "clk_andgt_uartl",
-	  CLK_SET_RATE_PARENT, 0xB0, 8, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xB0, 8, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_UART0, "clk_div_uart0", "clk_andgt_uart0",
-	  CLK_SET_RATE_PARENT, 0xB0, 4, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xB0, 4, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_I2C, "clk_div_i2c", "clk_div_320m",
-	  CLK_SET_RATE_PARENT, 0xE8, 4, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xE8, 4, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_SPI, "clk_div_spi", "clk_andgt_spi",
-	  CLK_SET_RATE_PARENT, 0xC4, 12, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xC4, 12, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_PCIEAXI, "clk_div_pcieaxi", "clk_andgt_pcieaxi",
-	  CLK_SET_RATE_PARENT, 0xb4, 0, 5, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xb4, 0, 5, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_AO_ASP, "clk_div_ao_asp", "clk_div_ao_asp_gt",
-	  CLK_SET_RATE_PARENT, 0x108, 6, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x108, 6, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_CSI_TRANS, "clk_div_csi_trans", "clk_gate_csi_trans",
-	  CLK_SET_RATE_PARENT, 0xD4, 0, 5, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xD4, 0, 5, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_DSI_TRANS, "clk_div_dsi_trans", "clk_gate_dsi_trans",
-	  CLK_SET_RATE_PARENT, 0xD4, 10, 5, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xD4, 10, 5, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_PTP, "clk_div_ptp", "clk_andgt_ptp",
-	  CLK_SET_RATE_PARENT, 0xD8, 0, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xD8, 0, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_CLKOUT0_PLL, "clk_div_clkout0_pll", "clk_andgt_out0",
-	  CLK_SET_RATE_PARENT, 0xe0, 4, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xe0, 4, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_CLKOUT1_PLL, "clk_div_clkout1_pll", "clk_andgt_out1",
-	  CLK_SET_RATE_PARENT, 0xe0, 10, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xe0, 10, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLKDIV_DP_AUDIO_PLL_AO, "clkdiv_dp_audio_pll_ao", "clkgt_dp_audio_pll_ao",
-	  CLK_SET_RATE_PARENT, 0xBC, 11, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xBC, 11, 4, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_VDEC, "clk_div_vdec", "clk_andgt_vdec",
-	  CLK_SET_RATE_PARENT, 0xC4, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xC4, 0, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_VENC, "clk_div_venc", "clk_andgt_venc",
-	  CLK_SET_RATE_PARENT, 0xC0, 8, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xC0, 8, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_ISP_SNCLK_DIV0, "clk_isp_snclk_div0", "clk_isp_snclk_fac",
-	  CLK_SET_RATE_PARENT, 0x108, 0, 2, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x108, 0, 2, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_ISP_SNCLK_DIV1, "clk_isp_snclk_div1", "clk_isp_snclk_fac",
-	  CLK_SET_RATE_PARENT, 0x10C, 14, 2, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x10C, 14, 2, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_ISP_SNCLK_DIV2, "clk_isp_snclk_div2", "clk_isp_snclk_fac",
-	  CLK_SET_RATE_PARENT, 0x10C, 11, 2, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x10C, 11, 2, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_ICS, "clk_div_ics", "clk_andgt_ics",
-	  CLK_SET_RATE_PARENT, 0xE4, 9, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0xE4, 9, 6, CLK_DIVIDER_HIWORD_MASK, },
 };
 
 /* clk_pmuctrl */
@@ -608,12 +608,12 @@ static const struct hisi_gate_clock hi3670_sctrl_gate_sep_clks[] = {
 
 static const struct hisi_gate_clock hi3670_sctrl_gate_clks[] = {
 	{ HI3670_CLK_ANDGT_IOPERI, "clk_andgt_ioperi", "clk_ppll0",
-	  CLK_SET_RATE_PARENT, 0x270, 6, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x270, 6, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLKANDGT_ASP_SUBSYS_PERI, "clkandgt_asp_subsys_peri",
 	  "clk_ppll0",
-	  CLK_SET_RATE_PARENT, 0x268, 3, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x268, 3, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANGT_ASP_SUBSYS, "clk_angt_asp_subsys", "clk_ppll0",
-	  CLK_SET_RATE_PARENT, 0x258, 0, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x258, 0, CLK_GATE_HIWORD_MASK, },
 };
 
 static const char *const
@@ -650,19 +650,19 @@ static const struct hisi_mux_clock hi3670_sctrl_mux_clks[] = {
 
 static const struct hisi_divider_clock hi3670_sctrl_divider_clks[] = {
 	{ HI3670_CLK_DIV_AOBUS, "clk_div_aobus", "clk_ppll0",
-	  CLK_SET_RATE_PARENT, 0x254, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x254, 0, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_UFS_SUBSYS, "clk_div_ufs_subsys", "clk_mux_ufs_subsys",
-	  CLK_SET_RATE_PARENT, 0x274, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x274, 0, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_IOPERI, "clk_div_ioperi", "clk_andgt_ioperi",
-	  CLK_SET_RATE_PARENT, 0x270, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x270, 0, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_CLKOUT0_TCXO, "clk_div_clkout0_tcxo", "clkin_sys",
-	  CLK_SET_RATE_PARENT, 0x254, 6, 3, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x254, 6, 3, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_CLKOUT1_TCXO, "clk_div_clkout1_tcxo", "clkin_sys",
-	  CLK_SET_RATE_PARENT, 0x254, 9, 3, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x254, 9, 3, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_ASP_SUBSYS_PERI_DIV, "clk_asp_subsys_peri_div", "clkandgt_asp_subsys_peri",
-	  CLK_SET_RATE_PARENT, 0x268, 0, 3, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x268, 0, 3, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_ASP_SUBSYS, "clk_div_asp_subsys", "clk_angt_asp_subsys",
-	  CLK_SET_RATE_PARENT, 0x250, 0, 3, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x250, 0, 3, CLK_DIVIDER_HIWORD_MASK, },
 };
 
 /* clk_iomcu */
@@ -732,17 +732,17 @@ static const struct hisi_gate_clock hi3670_media1_gate_sep_clks[] = {
 
 static const struct hisi_gate_clock hi3670_media1_gate_clks[] = {
 	{ HI3670_CLK_GATE_VIVOBUS_ANDGT, "clk_gate_vivobus_andgt", "clk_mux_vivobus",
-	  CLK_SET_RATE_PARENT, 0x84, 3, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x84, 3, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_EDC0, "clk_andgt_edc0", "clk_mux_edc0",
-	  CLK_SET_RATE_PARENT, 0x84, 7, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x84, 7, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_LDI0, "clk_andgt_ldi0", "clk_mux_ldi0",
-	  CLK_SET_RATE_PARENT, 0x84, 9, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x84, 9, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_LDI1, "clk_andgt_ldi1", "clk_mux_ldi1",
-	  CLK_SET_RATE_PARENT, 0x84, 8, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x84, 8, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_MMBUF_PLL_ANDGT, "clk_mmbuf_pll_andgt", "clk_sw_mmbuf",
-	  CLK_SET_RATE_PARENT, 0x84, 14, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x84, 14, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_PCLK_MMBUF_ANDGT, "pclk_mmbuf_andgt", "aclk_div_mmbuf",
-	  CLK_SET_RATE_PARENT, 0x84, 15, CLK_GATE_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x84, 15, CLK_GATE_HIWORD_MASK, },
 };
 
 static const char *const
@@ -799,17 +799,17 @@ static const struct hisi_mux_clock hi3670_media1_mux_clks[] = {
 
 static const struct hisi_divider_clock hi3670_media1_divider_clks[] = {
 	{ HI3670_CLK_DIV_VIVOBUS, "clk_div_vivobus", "clk_gate_vivobus_andgt",
-	  CLK_SET_RATE_PARENT, 0x74, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x74, 0, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_EDC0, "clk_div_edc0", "clk_andgt_edc0",
-	  CLK_SET_RATE_PARENT, 0x68, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x68, 0, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_LDI0, "clk_div_ldi0", "clk_andgt_ldi0",
-	  CLK_SET_RATE_PARENT, 0x60, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x60, 0, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_CLK_DIV_LDI1, "clk_div_ldi1", "clk_andgt_ldi1",
-	  CLK_SET_RATE_PARENT, 0x64, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x64, 0, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_ACLK_DIV_MMBUF, "aclk_div_mmbuf", "clk_mmbuf_pll_andgt",
-	  CLK_SET_RATE_PARENT, 0x7C, 10, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x7C, 10, 6, CLK_DIVIDER_HIWORD_MASK, },
 	{ HI3670_PCLK_DIV_MMBUF, "pclk_div_mmbuf", "pclk_mmbuf_andgt",
-	  CLK_SET_RATE_PARENT, 0x78, 0, 2, CLK_DIVIDER_HIWORD_MASK, 0, },
+	  CLK_SET_RATE_PARENT, 0x78, 0, 2, CLK_DIVIDER_HIWORD_MASK, },
 };
 
 /* clk_media2 */
-- 
2.23.0

