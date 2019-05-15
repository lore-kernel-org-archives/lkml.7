Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3A5C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 03:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00522084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 03:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfEOD7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 23:59:06 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52712 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfEOD7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 23:59:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A068A1A0170;
        Wed, 15 May 2019 05:59:03 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE9DC1A00B9;
        Wed, 15 May 2019 05:58:57 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B762540302;
        Wed, 15 May 2019 11:58:50 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        yangbo.lu@nxp.com, jiafei.pan@nxp.com,
        Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: [PATCH v2] arm64: dts: ls1028a: Add esdhc node in dts
Date:   Wed, 15 May 2019 12:00:46 +0800
Message-Id: <20190515040046.9230-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Kumar <Ashish.Kumar@nxp.com>

This patch is to add esdhc node and enable SD UHS-I,
eMMC HS200 for ls1028ardb/ls1028aqds board.

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v2:
		Update the patch title
		Add a commont in dts code

 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |    8 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts |   13 ++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |   27 +++++++++++++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 14c79f4..180e5d2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -42,6 +42,14 @@
 	status = "okay";
 };
 
+&esdhc {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index f86b054..1bfaf42 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -30,6 +30,19 @@
 	};
 };
 
+&esdhc {
+	status = "okay";
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	};
+
+&esdhc1 {
+	status = "okay";
+	mmc-hs200-1_8v;
+	};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 2896bbc..5c7546f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -274,6 +274,33 @@
 			status = "disabled";
 		};
 
+		esdhc: esdhc@2140000 {
+			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x2140000 0x0 0x10000>;
+			interrupts = <0 28 0x4>; /* Level high type */
+			clock-frequency = <0>; /* fixed up by bootloader */
+			clocks = <&clockgen 2 1>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		esdhc1: esdhc@2150000 {
+			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x2150000 0x0 0x10000>;
+			interrupts = <0 63 0x4>; /* Level high type */
+			clock-frequency = <0>; /* fixed up by bootloader */
+			clocks = <&clockgen 2 1>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			broken-cd;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		sata: sata@3200000 {
 			compatible = "fsl,ls1028a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>,
-- 
1.7.1

