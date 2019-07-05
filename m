Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B4C4649A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F83218BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfGEJDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:03:20 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60780 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbfGEJDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:03:20 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BCC04200BE1;
        Fri,  5 Jul 2019 11:03:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 05681200E68;
        Fri,  5 Jul 2019 11:03:10 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B7C75402DF;
        Fri,  5 Jul 2019 17:03:00 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, daniel.baluta@nxp.com, ping.bai@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Date:   Fri,  5 Jul 2019 16:54:05 +0800
Message-Id: <20190705085406.22483-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX8MM can reuse i.MX8MQ's reset driver, update the compatible
property and related info to support i.MX8MM.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V3:
	- Add comments to those reset indices to indicate which are NOT supported on i.MX8MM.
---
 .../devicetree/bindings/reset/fsl,imx7-src.txt     |  6 +++--
 include/dt-bindings/reset/imx8mq-reset.h           | 28 +++++++++++-----------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
index 13e0951..c2489e4 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible:
 	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
 	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
+	- For i.MX8MM SoCs should be "fsl,imx8mm-src", "fsl,imx8mq-src", "syscon"
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain SRC interrupt
@@ -46,5 +47,6 @@ Example:
 
 
 For list of all valid reset indices see
-<dt-bindings/reset/imx7-reset.h> for i.MX7 and
-<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
+<dt-bindings/reset/imx7-reset.h> for i.MX7,
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ and
+<dt-bindings/reset/imx8mq-reset.h> for i.MX8MM
diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
index 57c5924..f17ef2a 100644
--- a/include/dt-bindings/reset/imx8mq-reset.h
+++ b/include/dt-bindings/reset/imx8mq-reset.h
@@ -38,26 +38,26 @@
 #define IMX8MQ_RESET_PCIEPHY_PERST		27
 #define IMX8MQ_RESET_PCIE_CTRL_APPS_EN		28
 #define IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF	29
-#define IMX8MQ_RESET_HDMI_PHY_APB_RESET		30
+#define IMX8MQ_RESET_HDMI_PHY_APB_RESET		30	/* i.MX8MM does NOT support */
 #define IMX8MQ_RESET_DISP_RESET			31
 #define IMX8MQ_RESET_GPU_RESET			32
 #define IMX8MQ_RESET_VPU_RESET			33
-#define IMX8MQ_RESET_PCIEPHY2			34
-#define IMX8MQ_RESET_PCIEPHY2_PERST		35
-#define IMX8MQ_RESET_PCIE2_CTRL_APPS_EN		36
-#define IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF	37
-#define IMX8MQ_RESET_MIPI_CSI1_CORE_RESET	38
-#define IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET	39
-#define IMX8MQ_RESET_MIPI_CSI1_ESC_RESET	40
-#define IMX8MQ_RESET_MIPI_CSI2_CORE_RESET	41
-#define IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET	42
-#define IMX8MQ_RESET_MIPI_CSI2_ESC_RESET	43
+#define IMX8MQ_RESET_PCIEPHY2			34	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_PCIEPHY2_PERST		35	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_PCIE2_CTRL_APPS_EN		36	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF	37	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI1_CORE_RESET	38	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET	39	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI1_ESC_RESET	40	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI2_CORE_RESET	41	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET	42	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_MIPI_CSI2_ESC_RESET	43	/* i.MX8MM does NOT support */
 #define IMX8MQ_RESET_DDRC1_PRST			44
 #define IMX8MQ_RESET_DDRC1_CORE_RESET		45
 #define IMX8MQ_RESET_DDRC1_PHY_RESET		46
-#define IMX8MQ_RESET_DDRC2_PRST			47
-#define IMX8MQ_RESET_DDRC2_CORE_RESET		48
-#define IMX8MQ_RESET_DDRC2_PHY_RESET		49
+#define IMX8MQ_RESET_DDRC2_PRST			47	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_DDRC2_CORE_RESET		48	/* i.MX8MM does NOT support */
+#define IMX8MQ_RESET_DDRC2_PHY_RESET		49	/* i.MX8MM does NOT support */
 
 #define IMX8MQ_RESET_NUM			50
 
-- 
2.7.4

