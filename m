Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFD0C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1B4218C5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfGEJDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:03:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60808 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbfGEJDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:03:20 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E79B42006EB;
        Fri,  5 Jul 2019 11:03:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71FCE2001AE;
        Fri,  5 Jul 2019 11:03:11 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2A6B6402E5;
        Fri,  5 Jul 2019 17:03:02 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, daniel.baluta@nxp.com, ping.bai@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4 2/2] arm64: dts: imx8mm: Add "fsl,imx8mq-src" as src's fallback compatible
Date:   Fri,  5 Jul 2019 16:54:06 +0800
Message-Id: <20190705085406.22483-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705085406.22483-1-Anson.Huang@nxp.com>
References: <20190705085406.22483-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX8MM can reuse i.MX8MQ's src driver, add "fsl,imx8mq-src" as
src's fallback compatible to enable it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
No changes.
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 9db8efd..da5ee11 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -502,7 +502,7 @@
 			};
 
 			src: reset-controller@30390000 {
-				compatible = "fsl,imx8mm-src", "syscon";
+				compatible = "fsl,imx8mm-src", "fsl,imx8mq-src", "syscon";
 				reg = <0x30390000 0x10000>;
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
-- 
2.7.4

