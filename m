Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C8BFC6196
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B7521D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbfKGCIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:08:22 -0500
Received: from inva020.nxp.com ([92.121.34.13]:50812 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732713AbfKGCIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:08:14 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F5EE1A00CE;
        Thu,  7 Nov 2019 03:08:13 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E1BC1A00C2;
        Thu,  7 Nov 2019 03:08:07 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 60D1F402B7;
        Thu,  7 Nov 2019 10:07:59 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 3/4] ARM: dts: imx6sll: Add Rev A board support
Date:   Thu,  7 Nov 2019 10:06:32 +0800
Message-Id: <1573092393-26885-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573092393-26885-1-git-send-email-Anson.Huang@nxp.com>
References: <1573092393-26885-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL EVK Rev A board is same with latest i.MX6SLL EVK board except
eMMC can ONLY run at HS200 mode, add support for this board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Add board model and compatible to indicate it is a Rev-A board.
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/imx6sll-evk-reva.dts | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sll-evk-reva.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 71f08e7..3845bbf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -557,6 +557,7 @@ dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-warp.dtb
 dtb-$(CONFIG_SOC_IMX6SLL) += \
 	imx6sll-evk.dtb \
+	imx6sll-evk-reva.dtb \
 	imx6sll-kobo-clarahd.dtb
 dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-nitrogen6sx.dtb \
diff --git a/arch/arm/boot/dts/imx6sll-evk-reva.dts b/arch/arm/boot/dts/imx6sll-evk-reva.dts
new file mode 100644
index 0000000..e813c74
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sll-evk-reva.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2019 NXP.
+ *
+ */
+
+#include "imx6sll-evk.dts"
+
+/ {
+	model = "Freescale i.MX6SLL EVK RevA Board";
+	compatible = "fsl,imx6sll-evk-reva", "fsl,imx6sll";
+};
+
+&usdhc2 {
+	compatible = "fsl,imx6sll-usdhc", "fsl,imx6sx-usdhc";
+};
-- 
2.7.4

