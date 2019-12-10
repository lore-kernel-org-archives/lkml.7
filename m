Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EC6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE632073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tJ3H+WLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJJgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:36:22 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45252 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfLJJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:36:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBA9aAi7130979;
        Tue, 10 Dec 2019 03:36:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575970570;
        bh=uWER0qb6H5Cf0hNtns4SWA9SPJe2wvekXab6TK1FJts=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tJ3H+WLlIxHX6Xqz1ljZfOS1xsQNYkaVZsbp6MHg1MFBmyBGLix6zNDfiyeP+Mhmu
         aaikRRr2UQzcaCV7hOwuZ6d2z37ehciM+UtFNDAsctPoYg93HSu+PDW/wHrvTYyOvo
         jJPvAaLyOCJ5/+6ZiDhnTLZMt5GOjGRIMIXQ1bSI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBA9aAfc107589
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 03:36:10 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 03:36:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 03:36:10 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBA9a5iN014629;
        Tue, 10 Dec 2019 03:36:08 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am65: Add OSPI DT node
Date:   Tue, 10 Dec 2019 15:06:19 +0530
Message-ID: <20191210093619.22481-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210093619.22481-1-vigneshr@ti.com>
References: <20191210093619.22481-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 SoC has two Cadence OSPI controller instances under Flash
subsystem (FSS). Add DT nodes for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 38 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi           | 11 +++++-
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 36 ++++++++++++++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 7bdf5342f58f..aec720f35578 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -95,4 +95,42 @@ adc {
 			compatible = "ti,am654-adc", "ti,am3359-adc";
 		};
 	};
+
+	fss: fss@47000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ospi0: spi@47040000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x0 0x47040000 0x0 0x100>,
+				<0x5 0x00000000 0x1 0x0000000>;
+			interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x50000000>;
+			clocks = <&k3_clks 55 5>;
+			assigned-clocks = <&k3_clks 55 5>;
+			assigned-clock-parents = <&k3_clks 55 7>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 55 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		ospi1: spi@47050000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x0 0x47050000 0x0 0x100>,
+				<0x7 0x00000000 0x1 0x00000000>;
+			interrupts = <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x58000000>;
+			clocks = <&k3_clks 55 16>;
+			power-domains = <&k3_pds 55 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index 6dfccd5d56c8..d38720bc2551 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -80,7 +80,11 @@ cbass_main: interconnect@100000 {
 			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
 			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
 			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
-			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>;
+			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x8000000>,
+			 <0x00 0x70000000 0x00 0x70000000 0x00 0x200000>,
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x0000000>,
+			 <0x07 0x00000000 0x07 0x00000000 0x01 0x0000000>;
 
 		cbass_mcu: interconnect@28380000 {
 			compatible = "simple-bus";
@@ -94,7 +98,10 @@ cbass_mcu: interconnect@28380000 {
 				 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP */
 				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
 				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
-				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>; /* OSPI space 1 */
+				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI space 1 */
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x8000000>, /*  FSS OSPI0 data region 1 */
+				 <0x05 0x00000000 0x05 0x00000000 0x01 0x0000000>, /* FSS OSPI0 data region 3*/
+				 <0x07 0x00000000 0x07 0x00000000 0x01 0x0000000>; /* FSS OSPI1 data region 3*/
 
 			cbass_wakeup: interconnect@42040000 {
 				compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 8a85b482ad31..94bec7aa9baf 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -69,6 +69,22 @@ AM65X_WKUP_IOPAD(0x0030, PIN_INPUT, 7) /* (R5) WKUP_GPIO0_24 */
 			AM65X_WKUP_IOPAD(0x003c, PIN_INPUT, 7) /* (P2) WKUP_GPIO0_27 */
 		>;
 	};
+
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins_default {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* (V1) MCU_OSPI0_CLK */
+			AM65X_WKUP_IOPAD(0x0008, PIN_INPUT, 0)	 /* (U2) MCU_OSPI0_DQS */
+			AM65X_WKUP_IOPAD(0x000c, PIN_INPUT, 0)  /* (U4) MCU_OSPI0_D0 */
+			AM65X_WKUP_IOPAD(0x0010, PIN_INPUT, 0)  /* (U5) MCU_OSPI0_D1 */
+			AM65X_WKUP_IOPAD(0x0014, PIN_INPUT, 0)  /* (T2) MCU_OSPI0_D2 */
+			AM65X_WKUP_IOPAD(0x0018, PIN_INPUT, 0)  /* (T3) MCU_OSPI0_D3 */
+			AM65X_WKUP_IOPAD(0x001c, PIN_INPUT, 0)  /* (T4) MCU_OSPI0_D4 */
+			AM65X_WKUP_IOPAD(0x0020, PIN_INPUT, 0)  /* (T5) MCU_OSPI0_D5 */
+			AM65X_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* (R2) MCU_OSPI0_D6 */
+			AM65X_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* (R3) MCU_OSPI0_D7 */
+			AM65X_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* (R4) MCU_OSPI0_CSn0 */
+		>;
+	};
 };
 
 &main_pmx0 {
@@ -339,3 +355,23 @@ &mailbox0_cluster10 {
 &mailbox0_cluster11 {
 	status = "disabled";
 };
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+
+	flash@0{
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <40000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
-- 
2.24.0

