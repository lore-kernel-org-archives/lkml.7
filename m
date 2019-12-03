Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60867C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436F52068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCNM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:12:57 -0500
Received: from comms.puri.sm ([159.203.221.185]:60682 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfLCNM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:12:56 -0500
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Dec 2019 08:12:56 EST
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6C488E0301;
        Tue,  3 Dec 2019 05:04:07 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PfiCBJBd9cA1; Tue,  3 Dec 2019 05:04:06 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] arm64: dts: imx8mq-librem5-devkit: add accelerometer and gyro sensor
Date:   Tue,  3 Dec 2019 14:03:36 +0100
Message-Id: <20191203130336.18763-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is driver support, describe the accel and gyro sensor parts
of the LSM9DS1 IMU.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 683a11035643..7a92704c53ec 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -415,6 +415,13 @@
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
+	accel_gyro@6a {
+		compatible = "st,lsm9ds1-imu";
+		reg = <0x6a>;
+		vdd-supply = <&reg_3v3_p>;
+		vddio-supply = <&reg_3v3_p>;
+	};
+
 	magnetometer@1e	{
 		compatible = "st,lsm9ds1-magn";
 		reg = <0x1e>;
-- 
2.20.1

