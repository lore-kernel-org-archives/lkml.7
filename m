Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3F5C76191
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890EA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfGPDS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 23:18:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42872 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbfGPDS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:18:57 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E9580200066;
        Tue, 16 Jul 2019 05:18:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B10E200029;
        Tue, 16 Jul 2019 05:18:48 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A4358402D5;
        Tue, 16 Jul 2019 11:18:39 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] arm64: dts: imx8mm: Correct SAI3 RXC/TXFS pin's mux option #1
Date:   Tue, 16 Jul 2019 11:09:33 +0800
Message-Id: <20190716030933.30894-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

According to i.MX8MM reference manual Rev.1, 03/2019:

SAI3_RXC pin's mux option #1 should be GPT1_CLK, NOT GPT1_CAPTURE2;
SAI3_TXFS pin's mux option #1 should be GPT1_CAPTURE2, NOT GPT1_CLK.

Fixes: c1c9d41319c3 ("dt-bindings: imx: Add pinctrl binding doc for imx8mm")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index e25f7fc..cffa899 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -462,7 +462,7 @@
 #define MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28                                   0x1CC 0x434 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_RXFS_TPSMP_HTRANS0                                0x1CC 0x434 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI3_RXC_SAI3_RX_BCLK                                  0x1D0 0x438 0x000 0x0 0x0
-#define MX8MM_IOMUXC_SAI3_RXC_GPT1_CAPTURE2                                 0x1D0 0x438 0x000 0x1 0x0
+#define MX8MM_IOMUXC_SAI3_RXC_GPT1_CLK                                      0x1D0 0x438 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI3_RXC_SAI5_RX_BCLK                                  0x1D0 0x438 0x4D0 0x2 0x2
 #define MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29                                    0x1D0 0x438 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_RXC_TPSMP_HTRANS1                                 0x1D0 0x438 0x000 0x7 0x0
@@ -472,7 +472,7 @@
 #define MX8MM_IOMUXC_SAI3_RXD_GPIO4_IO30                                    0x1D4 0x43C 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_RXD_TPSMP_HDATA0                                  0x1D4 0x43C 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC                                 0x1D8 0x440 0x000 0x0 0x0
-#define MX8MM_IOMUXC_SAI3_TXFS_GPT1_CLK                                     0x1D8 0x440 0x000 0x1 0x0
+#define MX8MM_IOMUXC_SAI3_TXFS_GPT1_CAPTURE2                                0x1D8 0x440 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_SAI5_RX_DATA1                                0x1D8 0x440 0x4D8 0x2 0x2
 #define MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31                                   0x1D8 0x440 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_TPSMP_HDATA1                                 0x1D8 0x440 0x000 0x7 0x0
-- 
2.7.4

