Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174CBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC83C20898
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfKTVOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:14:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35775 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:14:07 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1iXXIU-0001J4-Nr; Wed, 20 Nov 2019 22:13:58 +0100
Received: from mgr by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1iXXIQ-0001Xb-BH; Wed, 20 Nov 2019 22:13:54 +0100
From:   Michael Grzeschik <m.grzeschik@pengutronix.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ARM: dts: imx25: describe maximum speed of internal usbhost port1 phy
Date:   Wed, 20 Nov 2019 22:13:34 +0100
Message-Id: <20191120211334.5580-3-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120211334.5580-1-m.grzeschik@pengutronix.de>
References: <20191120082955.3ovsoziurntmv7by@pengutronix.de>
 <20191120211334.5580-1-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal usbphy of usbhost port1 is only full-speed capable.
We set this limitation in the dtsi.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 7c7795b40ee0c..40b95a290bd6b 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -570,6 +570,7 @@
 				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 1>;
 				fsl,usbphy = <&usbphy1>;
+				maximum-speed = "full-speed";
 				phy_type = "serial";
 				dr_mode = "host";
 				status = "disabled";
-- 
2.24.0

