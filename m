Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAED4C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2546207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfLJOPV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:15:21 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:46170 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfLJOPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:15:21 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 2C77867A918;
        Tue, 10 Dec 2019 15:15:18 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Dec
 2019 15:15:17 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 10 Dec 2019 15:15:17 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: imx8mm: Add missing mux options for UART1 and
 UART2 signals
Thread-Topic: [PATCH] arm64: dts: imx8mm: Add missing mux options for UART1
 and UART2 signals
Thread-Index: AQHVr2Q/ATuBSnMk+E+vlzmoNWKRXQ==
Date:   Tue, 10 Dec 2019 14:15:17 +0000
Message-ID: <20191210141516.6983-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 2C77867A918.A01D5
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

According to the reference manual and the "Pins Tool" from NXP, the
signals for UART1 and UART2 can be muxed to the SAI2 and SAI3 pads
respectively. Let's add the missing options.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index cffa8991880d..5ccc4cc91959 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -430,18 +430,26 @@
 #define MX8MM_IOMUXC_SAI1_MCLK_SIM_M_HRESP                                  0x1AC 0x414 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI2_RXFS_SAI2_RX_SYNC                                 0x1B0 0x418 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI2_RXFS_SAI5_TX_SYNC                                 0x1B0 0x418 0x4EC 0x1 0x2
+#define MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX                                 0x1B0 0x418 0x000 0x4 0x0
+#define MX8MM_IOMUXC_SAI2_RXFS_UART1_DTE_RX                                 0x1B0 0x418 0x4F4 0x4 0x2
 #define MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21                                   0x1B0 0x418 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI2_RXFS_SIM_M_HSIZE0                                 0x1B0 0x418 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI2_RXC_SAI2_RX_BCLK                                  0x1B4 0x41C 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI2_RXC_SAI5_TX_BCLK                                  0x1B4 0x41C 0x4E8 0x1 0x2
+#define MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX                                  0x1B4 0x41C 0x4F4 0x4 0x3
+#define MX8MM_IOMUXC_SAI2_RXC_UART1_DTE_TX                                  0x1B4 0x41C 0x000 0x4 0x0
 #define MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22                                    0x1B4 0x41C 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI2_RXC_SIM_M_HSIZE1                                  0x1B4 0x41C 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0                                0x1B8 0x420 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI2_RXD0_SAI5_TX_DATA0                                0x1B8 0x420 0x000 0x1 0x0
+#define MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B                              0x1B8 0x420 0x4F0 0x4 0x2
+#define MX8MM_IOMUXC_SAI2_RXD0_UART1_DTE_CTS_B                              0x1B8 0x420 0x000 0x4 0x0
 #define MX8MM_IOMUXC_SAI2_RXD0_GPIO4_IO23                                   0x1B8 0x420 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI2_RXD0_SIM_M_HSIZE2                                 0x1B8 0x420 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC                                 0x1BC 0x424 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI2_TXFS_SAI5_TX_DATA1                                0x1BC 0x424 0x000 0x1 0x0
+#define MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B                              0x1BC 0x424 0x000 0x4 0x0
+#define MX8MM_IOMUXC_SAI2_TXFS_UART1_DTE_RTS_B                              0x1BC 0x424 0x4F0 0x4 0x3
 #define MX8MM_IOMUXC_SAI2_TXFS_GPIO4_IO24                                   0x1BC 0x424 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI2_TXFS_SIM_M_HWRITE                                 0x1BC 0x424 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK                                  0x1C0 0x428 0x000 0x0 0x0
@@ -464,21 +472,29 @@
 #define MX8MM_IOMUXC_SAI3_RXC_SAI3_RX_BCLK                                  0x1D0 0x438 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI3_RXC_GPT1_CLK                                      0x1D0 0x438 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI3_RXC_SAI5_RX_BCLK                                  0x1D0 0x438 0x4D0 0x2 0x2
+#define MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B                               0x1D0 0x438 0x000 0x4 0x0
+#define MX8MM_IOMUXC_SAI3_RXC_UART2_DTE_RTS_B                               0x1D0 0x438 0x4F8 0x4 0x2
 #define MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29                                    0x1D0 0x438 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_RXC_TPSMP_HTRANS1                                 0x1D0 0x438 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0                                 0x1D4 0x43C 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI3_RXD_GPT1_COMPARE1                                 0x1D4 0x43C 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI3_RXD_SAI5_RX_DATA0                                 0x1D4 0x43C 0x4D4 0x2 0x2
+#define MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B                               0x1D4 0x43C 0x4F8 0x4 0x3
+#define MX8MM_IOMUXC_SAI3_RXD_UART2_DTE_CTS_B                               0x1D4 0x43C 0x000 0x4 0x0
 #define MX8MM_IOMUXC_SAI3_RXD_GPIO4_IO30                                    0x1D4 0x43C 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_RXD_TPSMP_HDATA0                                  0x1D4 0x43C 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC                                 0x1D8 0x440 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_GPT1_CAPTURE2                                0x1D8 0x440 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_SAI5_RX_DATA1                                0x1D8 0x440 0x4D8 0x2 0x2
+#define MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX                                 0x1D8 0x440 0x4Fc 0x4 0x2
+#define MX8MM_IOMUXC_SAI3_TXFS_UART2_DTE_TX                                 0x1D8 0x440 0x000 0x4 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31                                   0x1D8 0x440 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_TPSMP_HDATA1                                 0x1D8 0x440 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK                                  0x1DC 0x444 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI3_TXC_GPT1_COMPARE2                                 0x1DC 0x444 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI3_TXC_SAI5_RX_DATA2                                 0x1DC 0x444 0x4DC 0x2 0x2
+#define MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX                                  0x1DC 0x444 0x000 0x4 0x0
+#define MX8MM_IOMUXC_SAI3_TXC_UART2_DTE_RX                                  0x1DC 0x444 0x4Fc 0x4 0x3
 #define MX8MM_IOMUXC_SAI3_TXC_GPIO5_IO0                                     0x1DC 0x444 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_TXC_TPSMP_HDATA2                                  0x1DC 0x444 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0                                 0x1E0 0x448 0x000 0x0 0x0
-- 
2.17.1
