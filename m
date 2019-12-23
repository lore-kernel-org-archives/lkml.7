Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D830C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E078A21655
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfLWINI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:13:08 -0500
Received: from comms.puri.sm ([159.203.221.185]:48782 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfLWINH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:13:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id AC59CDF30C;
        Mon, 23 Dec 2019 00:13:06 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cyX3Vz4KZq4B; Mon, 23 Dec 2019 00:13:06 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     shawnguo@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 2/2] arm64: dts: imx8mq-librem5-devkit: use correct interrupt for the magnetometer
Date:   Mon, 23 Dec 2019 09:12:53 +0100
Message-Id: <20191223081253.27516-2-martin.kepplinger@puri.sm>
In-Reply-To: <20191223081253.27516-1-martin.kepplinger@puri.sm>
References: <20191223081253.27516-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

The LSM9DS1 uses a high level interrupt.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 379510886e3e..b025b9a73e5e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -430,7 +430,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_imu>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 		vdd-supply = <&reg_3v3_p>;
 		vddio-supply = <&reg_3v3_p>;
 	};
-- 
2.20.1

