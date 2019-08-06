Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C16C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549DC2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfHFIwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:52:10 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38654 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbfHFIwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:52:07 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C4F11A05BC;
        Tue,  6 Aug 2019 10:52:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D9A001A05AA;
        Tue,  6 Aug 2019 10:52:01 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 780D3402E6;
        Tue,  6 Aug 2019 16:51:54 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 3/4] arm64: dts: ls1028a: Fix incorrect I2C clock divider
Date:   Tue,  6 Aug 2019 16:42:22 +0800
Message-Id: <20190806084223.23543-3-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190806084223.23543-1-chuanhua.han@nxp.com>
References: <20190806084223.23543-1-chuanhua.han@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ls1028a platform, the i2c input clock is actually platform pll CLK / 4
(this is the hardware connection), other clock divider can not get the
correct i2c clock, resulting in the output of SCL pin clock is not
accurate.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index aef5b06..cca7bfdb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -171,7 +171,7 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2000000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen 4 3>;
 			status = "disabled";
 		};
 
@@ -181,7 +181,7 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2010000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen 4 3>;
 			status = "disabled";
 		};
 
@@ -191,7 +191,7 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2020000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen 4 3>;
 			status = "disabled";
 		};
 
@@ -201,7 +201,7 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2030000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen 4 3>;
 			status = "disabled";
 		};
 
@@ -211,7 +211,7 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2040000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen 4 3>;
 			status = "disabled";
 		};
 
@@ -221,7 +221,7 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2050000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen 4 3>;
 			status = "disabled";
 		};
 
@@ -231,7 +231,7 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2060000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen 4 3>;
 			status = "disabled";
 		};
 
@@ -241,7 +241,7 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2070000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen 4 3>;
 			status = "disabled";
 		};
 
-- 
2.9.5

