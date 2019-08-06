Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DBFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F10208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbfHFIwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:52:14 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38650 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732440AbfHFIwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:52:08 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4BD6A1A05BB;
        Tue,  6 Aug 2019 10:52:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D98FC1A0027;
        Tue,  6 Aug 2019 10:52:01 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5F26040310;
        Tue,  6 Aug 2019 16:51:55 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 4/4] arm64: dts: lx2160a: Fix incorrect I2C clock divider
Date:   Tue,  6 Aug 2019 16:42:23 +0800
Message-Id: <20190806084223.23543-4-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190806084223.23543-1-chuanhua.han@nxp.com>
References: <20190806084223.23543-1-chuanhua.han@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lx2160a platform, the i2c input clock is actually platform pll CLK / 16
(this is the hardware connection), other clock divider can not get the
correct i2c clock, resulting in the output of SCL pin clock is not
accurate.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 4720a8e..408e0ec 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -485,7 +485,7 @@
 			reg = <0x0 0x2000000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen 4 15>;
 			scl-gpio = <&gpio2 15 GPIO_ACTIVE_HIGH>;
 			status = "disabled";
 		};
@@ -497,7 +497,7 @@
 			reg = <0x0 0x2010000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen 4 15>;
 			status = "disabled";
 		};
 
@@ -508,7 +508,7 @@
 			reg = <0x0 0x2020000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen 4 15>;
 			status = "disabled";
 		};
 
@@ -519,7 +519,7 @@
 			reg = <0x0 0x2030000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen 4 15>;
 			status = "disabled";
 		};
 
@@ -530,7 +530,7 @@
 			reg = <0x0 0x2040000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen 4 15>;
 			scl-gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;
 			status = "disabled";
 		};
@@ -542,7 +542,7 @@
 			reg = <0x0 0x2050000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen 4 15>;
 			status = "disabled";
 		};
 
@@ -553,7 +553,7 @@
 			reg = <0x0 0x2060000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen 4 15>;
 			status = "disabled";
 		};
 
@@ -564,7 +564,7 @@
 			reg = <0x0 0x2070000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen 4 15>;
 			status = "disabled";
 		};
 
-- 
2.9.5

