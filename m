Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D1C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC3E21841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388858AbfEXGho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:37:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42892 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387936AbfEXGho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:37:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F8122001F9;
        Fri, 24 May 2019 08:37:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE23C20021F;
        Fri, 24 May 2019 08:37:35 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7975B402E0;
        Fri, 24 May 2019 14:37:27 +0800 (SGT)
From:   peng.fan@nxp.com
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        van.freenix@gmail.com, Peng Fan <peng.fan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH V3 RESEND AGAIN 2/2] arm64: dts: imx: add i.MX8QXP ocotp support
Date:   Fri, 24 May 2019 14:39:13 +0800
Message-Id: <20190524063913.44171-2-peng.fan@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524063913.44171-1-peng.fan@nxp.com>
References: <20190524063913.44171-1-peng.fan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QXP ocotp node

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Anson Huang <anson.huang@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Add R-b tag
V2:
 move address/size-cells below compatible, add "scu"

 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 0683ee2a48ae..725d341ee160 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -141,6 +141,12 @@
 			compatible = "fsl,imx8qxp-iomuxc";
 		};
 
+		ocotp: imx8qx-ocotp {
+			compatible = "fsl,imx8qxp-scu-ocotp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		pd: imx8qx-pd {
 			compatible = "fsl,imx8qxp-scu-pd";
 			#power-domain-cells = <1>;
-- 
2.16.4

