Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EFBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA5A214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="spStOvHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbfJ1Jho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:37:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50046 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733224AbfJ1Jhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:37:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9S9baxP111328;
        Mon, 28 Oct 2019 04:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572255456;
        bh=3wwLSChl77jpkXMK71yrcydRlb1ZTHR8pcWLuLcJ2nc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=spStOvHWxc0inLl4sxnsTCXc3X3jb1ZkAvaCknJx+16Zc60ryotk5LdXHQ98QJkyv
         7hNJp+GTt3l/CYhQshPusU9w2g2XeR9zHGrbzgC4C+zWBxRz6WxlavPIHUvM7YtCTW
         xrzjSL1gxf0VkBZqdMz9cuvXndsL3/9Fh9eTXhKc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9S9baca062672;
        Mon, 28 Oct 2019 04:37:36 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 04:37:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 04:37:24 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9S9bW4h027237;
        Mon, 28 Oct 2019 04:37:34 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721e-main: add USB controller nodes
Date:   Mon, 28 Oct 2019 11:37:29 +0200
Message-ID: <20191028093730.23094-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028093730.23094-1-rogerq@ti.com>
References: <20191028093730.23094-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721e has 2 USB super-speed controllers add them.

The USB2 PHY doesn't need any configuration.
USB3 PHY needs to be implemented using the Cadence
Sierra PHY. This support will be added later.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 60 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi      |  2 +
 2 files changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 5dd2a69402e6..1e4c2b78d66d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -536,4 +536,64 @@
 		dma-coherent;
 		no-1-8-v;
 	};
+
+	usbss0: cdns_usb@4104000 {
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x4104000 0x00 0x100>;
+		dma-coherent;
+		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 288 15>, <&k3_clks 288 3>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 288 15>;	/* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		usb0: usb@6000000 {
+			compatible = "cdns,usb3";
+			reg = <0x00 0x6000000 0x00 0x10000>,
+			      <0x00 0x6010000 0x00 0x10000>,
+			      <0x00 0x6020000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+			maximum-speed = "super-speed";
+			dr_mode = "otg";
+		};
+	};
+
+	usbss1: cdns_usb@4114000 {
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x4114000 0x00 0x100>;
+		dma-coherent;
+		power-domains = <&k3_pds 289 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 289 15>, <&k3_clks 289 3>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 289 15>;	/* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 289 16>; /* HFOSC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		usb1: usb@6400000 {
+			compatible = "cdns,usb3";
+			reg = <0x00 0x6400000 0x00 0x10000>,
+			      <0x00 0x6410000 0x00 0x10000>,
+			      <0x00 0x6420000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+			maximum-speed = "super-speed";
+			dr_mode = "otg";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index 43ea1ba97922..ee5470edb435 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -127,6 +127,8 @@
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
 			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
 			 <0x00 0x00A40000 0x00 0x00A40000 0x00 0x00000800>, /* timesync router */
+			 <0x00 0x06000000 0x00 0x06000000 0x00 0x00400000>, /* USBSS0 */
+			 <0x00 0x06400000 0x00 0x06400000 0x00 0x00400000>, /* USBSS1 */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
 			 <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>, /* MAIN NAVSS */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* PCIe Core*/
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

