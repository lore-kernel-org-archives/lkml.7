Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D7AC282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8475C27A74
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfFCBdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 21:33:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46572 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfFCBdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:33:38 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 49FA220032C;
        Mon,  3 Jun 2019 03:33:36 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 60BA020011D;
        Mon,  3 Jun 2019 03:33:24 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F274E402DD;
        Mon,  3 Jun 2019 09:33:10 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, maxime.ripard@bootlin.com, olof@lixom.net,
        horms+renesas@verge.net.au, jagan@amarulasolutions.com,
        bjorn.andersson@linaro.org, leonard.crestez@nxp.com,
        dinguyen@kernel.org, enric.balletbo@collabora.com,
        aisheng.dong@nxp.com, ping.bai@nxp.com, abel.vesa@nxp.com,
        l.stach@pengutronix.de, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 3/3] arm64: defconfig: Select CONFIG_CLK_IMX8MN by default
Date:   Mon,  3 Jun 2019 09:35:03 +0800
Message-Id: <20190603013503.40626-3-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603013503.40626-1-Anson.Huang@nxp.com>
References: <20190603013503.40626-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Enable CONFIG_CLK_IMX8MN to support i.MX8MN clock driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8d4f25c..aef797c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -654,6 +654,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_CLK_IMX8MN=y
 CONFIG_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
-- 
2.7.4

