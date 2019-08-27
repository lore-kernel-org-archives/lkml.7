Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327B8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1462A206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfH0Mby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:31:54 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:52918 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfH0Mbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:31:52 -0400
Received: from erd987.prtnl (erd987.prtnl [192.168.237.3])
        by sparta (Postfix) with ESMTP id 8694B44A00C5;
        Tue, 27 Aug 2019 14:33:48 +0200 (CEST)
From:   Robin van der Gracht <robin@protonic.nl>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "devicetree @ vger . kernel . org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel @ lists . infradead . org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        "linux-input @ vger . kernel . org" <linux-input@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 2/2] arm: dts: imx6qdl: snvs-pwrkey: Change compatible string
Date:   Tue, 27 Aug 2019 14:32:16 +0200
Message-Id: <20190827123216.32728-2-robin@protonic.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190827123216.32728-1-robin@protonic.nl>
References: <20190827123216.32728-1-robin@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The older imx6 SoCs do not send a power key press interrupt, instead it
sends a power down request interrupt when the key is released between
750ms and 5 seconds. The driver uses a different compatible string to ID
the older SoCs.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b3a77bcf00d5..91b97816881c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -836,7 +836,7 @@
 				};
 
 				snvs_pwrkey: snvs-powerkey {
-					compatible = "fsl,sec-v4.0-pwrkey";
+					compatible = "fsl,imx6qdl-snvs-pwrkey";
 					regmap = <&snvs>;
 					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 					linux,keycode = <KEY_POWER>;
-- 
2.20.1

