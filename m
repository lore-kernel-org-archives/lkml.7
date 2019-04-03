Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C68214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rGcnjLq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDCOxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:53:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44252 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDCOxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:53:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x33ErlhG117565;
        Wed, 3 Apr 2019 09:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554303227;
        bh=oBtdD6gSgQV+WWSZ70BbRTCcMxym20rjaL157GLcQgg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rGcnjLq28FgXRfKwrY6i0dqGtNTiWbbJnaiY+/dls8+34z5BBKxmdPy8XsDWv1M7+
         rndxGFkuLMBQ03wYOmm4lYmQoa0jRKWTnVGOv3hv7cP2dh4b7AatqOKdpF9z8FYjWs
         wfCy7+RKMwItjmT9/7XSnA2hRE0auxzhd2Nc5cvE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x33ErlWd033253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Apr 2019 09:53:47 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 3 Apr
 2019 09:53:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 3 Apr 2019 09:53:45 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x33ErhlO095257;
        Wed, 3 Apr 2019 09:53:44 -0500
Subject: Re: [RFC PATCH 1/4] ARM: dts: dra7: Keep usb_otg_ss3 and usb_otg_ss4
 disabled
To:     Tony Lindgren <tony@atomide.com>
CC:     <nsekhar@ti.com>, <s-anna@ti.com>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        "Kristo, Tero" <t-kristo@ti.com>
References: <20190402133752.6912-1-rogerq@ti.com>
 <20190402133752.6912-2-rogerq@ti.com> <20190402162203.GL49658@atomide.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <001699f0-a143-5174-692b-78f53098f8aa@ti.com>
Date:   Wed, 3 Apr 2019 17:53:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402162203.GL49658@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

On 02/04/2019 19:22, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190402 13:38]:
>> These 2 modules are not present on all families (e.g. AM57).
>> Keep them disabled.
> 
> Can you please add comments to the dtsi file for why "disabled"
> is set? Otherwise we may end up removing them at some point as
> the default should be just enabled with no status property.
> 
> If these devices are really there for some SoCs, we should
> have a separate dtsi for them.
> 
> Regards,
> 
> Tony
> 

Below patch is just to get initial feedback. Is the overall approach of splitting
into DRA7 vs AM5 dtsi files OK?

From 12d3b0086dbf59acc57dddb6e6037d3c5c09878a Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq@ti.com>
Date: Wed, 3 Apr 2019 16:08:54 +0300
Subject: [PATCH] ARM: dts: dra7: Seperate AM5 and DRA7 dtsi files

AM5 and DRA7 SoC families have different set of modules
in them so the SoC specific dtsi files need to be separated.

e.g. Some of the major differences between AM576 and DRA76

		DRA76x	AM576x

USB3		x
USB4		x
ATL		x
VCP		x
MLB		x
ISS		x
PRU-ICSS1		x
PRU-ICSS2		x

This patch only deals with moving USB3 and USB4 to DRA7
specific files. PRU-ICSS support is not yet added. It can
be added to AM5 specific files.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am5718.dtsi                 |   5 +
 arch/arm/boot/dts/am571x-idk.dts              |   2 +-
 arch/arm/boot/dts/am5728.dtsi                 |   6 +
 arch/arm/boot/dts/am572x-idk.dts              |   5 +-
 arch/arm/boot/dts/am5748.dtsi                 |   5 +
 arch/arm/boot/dts/am574x-idk.dts              |   4 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts     |   2 +-
 arch/arm/boot/dts/dra7-l4-jacinto.dtsi        |  73 +++++++++
 arch/arm/boot/dts/dra7-l4.dtsi                |  74 +--------
 .../dts/{dra72x.dtsi => dra72x-common.dtsi}   |   2 -
 arch/arm/boot/dts/dra72x.dtsi                 |  62 +-------
 .../dts/{dra74x.dtsi => dra74x-common.dtsi}   |   2 -
 arch/arm/boot/dts/dra74x.dtsi                 | 147 +-----------------
 .../dts/{dra76x.dtsi => dra76x-common.dtsi}   |   2 -
 arch/arm/boot/dts/dra76x.dtsi                 |  81 +---------
 15 files changed, 103 insertions(+), 369 deletions(-)
 create mode 100644 arch/arm/boot/dts/am5718.dtsi
 create mode 100644 arch/arm/boot/dts/am5728.dtsi
 create mode 100644 arch/arm/boot/dts/am5748.dtsi
 create mode 100644 arch/arm/boot/dts/dra7-l4-jacinto.dtsi
 copy arch/arm/boot/dts/{dra72x.dtsi => dra72x-common.dtsi} (96%)
 copy arch/arm/boot/dts/{dra74x.dtsi => dra74x-common.dtsi} (98%)
 copy arch/arm/boot/dts/{dra76x.dtsi => dra76x-common.dtsi} (98%)

diff --git a/arch/arm/boot/dts/am5718.dtsi b/arch/arm/boot/dts/am5718.dtsi
new file mode 100644
index 000000000000..b6e4db5c9f55
--- /dev/null
+++ b/arch/arm/boot/dts/am5718.dtsi
@@ -0,0 +1,5 @@
+#include "dra72x-common.dtsi"
+
+/ {
+	compatible = "ti,am5718", "ti,dra7";
+};
diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 6432309b39e3..66116ad3f9f4 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-#include "dra72x.dtsi"
+#include "am5718.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "dra7-mmc-iodelay.dtsi"
diff --git a/arch/arm/boot/dts/am5728.dtsi b/arch/arm/boot/dts/am5728.dtsi
new file mode 100644
index 000000000000..7b1fcffd3103
--- /dev/null
+++ b/arch/arm/boot/dts/am5728.dtsi
@@ -0,0 +1,6 @@
+#include "dra74x-common.dtsi"
+
+
+/ {
+	compatible = "ti,am5728", "ti,dra7";
+};
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index b2fb6e097be7..4f835222c266 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -8,15 +8,14 @@
 
 /dts-v1/;
 
-#include "dra74x.dtsi"
+#include "am5728.dtsi"
 #include "dra7-mmc-iodelay.dtsi"
 #include "dra74x-mmc-iodelay.dtsi"
 #include "am572x-idk-common.dtsi"
 
 / {
 	model = "TI AM5728 IDK";
-	compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74",
-		     "ti,dra7";
+	compatible = "ti,am5728-idk", "ti,am5728", "ti,dra7";
 };
 
 &mmc1 {
diff --git a/arch/arm/boot/dts/am5748.dtsi b/arch/arm/boot/dts/am5748.dtsi
new file mode 100644
index 000000000000..4d809d60d24a
--- /dev/null
+++ b/arch/arm/boot/dts/am5748.dtsi
@@ -0,0 +1,5 @@
+#include "dra76x-common.dtsi"
+
+/ {
+	compatible = "ti,am5748", "ti,dra7";
+};
diff --git a/arch/arm/boot/dts/am574x-idk.dts b/arch/arm/boot/dts/am574x-idk.dts
index 378dfa780ac1..c61fbe1c22ae 100644
--- a/arch/arm/boot/dts/am574x-idk.dts
+++ b/arch/arm/boot/dts/am574x-idk.dts
@@ -6,14 +6,14 @@
 
 /dts-v1/;
 
-#include "dra76x.dtsi"
+#include "am5748.dtsi"
 #include "dra7-mmc-iodelay.dtsi"
 #include "dra76x-mmc-iodelay.dtsi"
 #include "am572x-idk-common.dtsi"
 
 / {
 	model = "TI AM5748 IDK";
-	compatible = "ti,am5728-idk", "ti,dra762", "ti,dra7";
+	compatible = "ti,am5748-idk", "ti,am5748", "ti,dra7";
 };
 
 &qspi {
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 4748ce8747ad..0460de0da2bf 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -13,7 +13,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "dra74x.dtsi"
+#include "am5728.dtsi"
 
 / {
 	model = "CompuLab CL-SOM-AM57x";
diff --git a/arch/arm/boot/dts/dra7-l4-jacinto.dtsi b/arch/arm/boot/dts/dra7-l4-jacinto.dtsi
new file mode 100644
index 000000000000..d8376ec401f5
--- /dev/null
+++ b/arch/arm/boot/dts/dra7-l4-jacinto.dtsi
@@ -0,0 +1,73 @@
+&l4cfg_segment0 {
+	target-module@100000 {			/* 0x48900000, ap 85 04.0 */
+		compatible = "ti,sysc-omap4", "ti,sysc";
+		ti,hwmods = "usb_otg_ss3";
+		reg = <0x100000 0x4>,
+		      <0x100010 0x4>;
+		reg-names = "rev", "sysc";
+		ti,sysc-mask = <SYSC_OMAP4_DMADISABLE>;
+		ti,sysc-midle = <SYSC_IDLE_FORCE>,
+				<SYSC_IDLE_NO>,
+				<SYSC_IDLE_SMART>,
+				<SYSC_IDLE_SMART_WKUP>;
+		ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+				<SYSC_IDLE_NO>,
+				<SYSC_IDLE_SMART>,
+				<SYSC_IDLE_SMART_WKUP>;
+		/* Domains (P, C): l3init_pwrdm, l3init_clkdm */
+		clocks = <&l3init_clkctrl DRA7_L3INIT_USB_OTG_SS3_CLKCTRL 0>;
+		clock-names = "fck";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x100000 0x20000>;
+
+		omap_dwc3_3: omap_dwc3_3@0 {
+			compatible = "ti,dwc3";
+			reg = <0x0 0x10000>;
+			interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			utmi-mode = <2>;
+			ranges = <0 0 0x20000>;
+			status = "disabled";
+
+			usb3: usb@10000 {
+				compatible = "snps,dwc3";
+				reg = <0x10000 0x17000>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
+				maximum-speed = "high-speed";
+				dr_mode = "otg";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
+			};
+		};
+	};
+
+	target-module@140000 {			/* 0x48940000, ap 75 3c.0 */
+		compatible = "ti,sysc-omap4", "ti,sysc";
+		ti,hwmods = "usb_otg_ss4";
+		reg = <0x140000 0x4>,
+		      <0x140010 0x4>;
+		reg-names = "rev", "sysc";
+		ti,sysc-mask = <SYSC_OMAP4_DMADISABLE>;
+		ti,sysc-midle = <SYSC_IDLE_FORCE>,
+				<SYSC_IDLE_NO>,
+				<SYSC_IDLE_SMART>,
+				<SYSC_IDLE_SMART_WKUP>;
+		ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+				<SYSC_IDLE_NO>,
+				<SYSC_IDLE_SMART>,
+				<SYSC_IDLE_SMART_WKUP>;
+		/* Domains (P, C): l3init_pwrdm, l3init_clkdm */
+		clocks = <&l3init_clkctrl DRA7_L3INIT_USB_OTG_SS4_CLKCTRL 0>;
+		clock-names = "fck";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x140000 0x20000>;
+	};
+};
diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 414f1cd68733..733e31898e6a 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -10,7 +10,7 @@
 		 <0x00100000 0x4a100000 0x100000>,	/* segment 1 */
 		 <0x00200000 0x4a200000 0x100000>;	/* segment 2 */
 
-	segment@0 {					/* 0x4a000000 */
+	l4cfg_segment0: segment@0 {					/* 0x4a000000 */
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -4099,78 +4099,6 @@
 			};
 		};
 
-		target-module@100000 {			/* 0x48900000, ap 85 04.0 */
-			compatible = "ti,sysc-omap4", "ti,sysc";
-			ti,hwmods = "usb_otg_ss3";
-			reg = <0x100000 0x4>,
-			      <0x100010 0x4>;
-			reg-names = "rev", "sysc";
-			ti,sysc-mask = <SYSC_OMAP4_DMADISABLE>;
-			ti,sysc-midle = <SYSC_IDLE_FORCE>,
-					<SYSC_IDLE_NO>,
-					<SYSC_IDLE_SMART>,
-					<SYSC_IDLE_SMART_WKUP>;
-			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
-					<SYSC_IDLE_NO>,
-					<SYSC_IDLE_SMART>,
-					<SYSC_IDLE_SMART_WKUP>;
-			/* Domains (P, C): l3init_pwrdm, l3init_clkdm */
-			clocks = <&l3init_clkctrl DRA7_L3INIT_USB_OTG_SS3_CLKCTRL 0>;
-			clock-names = "fck";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x0 0x100000 0x20000>;
-
-			omap_dwc3_3: omap_dwc3_3@0 {
-				compatible = "ti,dwc3";
-				reg = <0x0 0x10000>;
-				interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				utmi-mode = <2>;
-				ranges = <0 0 0x20000>;
-				status = "disabled";
-
-				usb3: usb@10000 {
-					compatible = "snps,dwc3";
-					reg = <0x10000 0x17000>;
-					interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
-						     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
-						     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "peripheral",
-							  "host",
-							  "otg";
-					maximum-speed = "high-speed";
-					dr_mode = "otg";
-					snps,dis_u3_susphy_quirk;
-					snps,dis_u2_susphy_quirk;
-				};
-			};
-		};
-
-		target-module@140000 {			/* 0x48940000, ap 75 3c.0 */
-			compatible = "ti,sysc-omap4", "ti,sysc";
-			ti,hwmods = "usb_otg_ss4";
-			reg = <0x140000 0x4>,
-			      <0x140010 0x4>;
-			reg-names = "rev", "sysc";
-			ti,sysc-mask = <SYSC_OMAP4_DMADISABLE>;
-			ti,sysc-midle = <SYSC_IDLE_FORCE>,
-					<SYSC_IDLE_NO>,
-					<SYSC_IDLE_SMART>,
-					<SYSC_IDLE_SMART_WKUP>;
-			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
-					<SYSC_IDLE_NO>,
-					<SYSC_IDLE_SMART>,
-					<SYSC_IDLE_SMART_WKUP>;
-			/* Domains (P, C): l3init_pwrdm, l3init_clkdm */
-			clocks = <&l3init_clkctrl DRA7_L3INIT_USB_OTG_SS4_CLKCTRL 0>;
-			clock-names = "fck";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x0 0x140000 0x20000>;
-		};
-
 		target-module@170000 {			/* 0x48970000, ap 21 0a.0 */
 			compatible = "ti,sysc";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x-common.dtsi
similarity index 96%
copy from arch/arm/boot/dts/dra72x.dtsi
copy to arch/arm/boot/dts/dra72x-common.dtsi
index 89831552cd86..b3ca9733fe5f 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x-common.dtsi
@@ -10,8 +10,6 @@
 #include "dra7.dtsi"
 
 / {
-	compatible = "ti,dra722", "ti,dra72", "ti,dra7";
-
 	pmu {
 		compatible = "arm,cortex-a15-pmu";
 		interrupt-parent = <&wakeupgen>;
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index 89831552cd86..7a4a58da8dec 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -1,64 +1,6 @@
-/*
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- * Based on "omap4.dtsi"
- */
-
-#include "dra7.dtsi"
+#include "dra72x-common.dtsi"
+#include "dra7-l4-jacinto.dtsi"
 
 / {
 	compatible = "ti,dra722", "ti,dra72", "ti,dra7";
-
-	pmu {
-		compatible = "arm,cortex-a15-pmu";
-		interrupt-parent = <&wakeupgen>;
-		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-	};
-};
-
-&dss {
-	reg = <0x58000000 0x80>,
-	      <0x58004054 0x4>,
-	      <0x58004300 0x20>;
-	reg-names = "dss", "pll1_clkctrl", "pll1";
-
-	clocks = <&dss_clkctrl DRA7_DSS_DSS_CORE_CLKCTRL 8>,
-		 <&dss_clkctrl DRA7_DSS_DSS_CORE_CLKCTRL 12>;
-	clock-names = "fck", "video1_clk";
-};
-
-&mailbox5 {
-	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
-		ti,mbox-tx = <6 2 2>;
-		ti,mbox-rx = <4 2 2>;
-		status = "disabled";
-	};
-	mbox_dsp1_ipc3x: mbox_dsp1_ipc3x {
-		ti,mbox-tx = <5 2 2>;
-		ti,mbox-rx = <1 2 2>;
-		status = "disabled";
-	};
-};
-
-&mailbox6 {
-	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
-		ti,mbox-tx = <6 2 2>;
-		ti,mbox-rx = <4 2 2>;
-		status = "disabled";
-	};
-};
-
-&pcie1_rc {
-	compatible = "ti,dra726-pcie-rc", "ti,dra7-pcie";
-};
-
-&pcie1_ep {
-	compatible = "ti,dra726-pcie-ep", "ti,dra7-pcie-ep";
-};
-
-&pcie2_rc {
-	compatible = "ti,dra726-pcie-rc", "ti,dra7-pcie";
 };
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x-common.dtsi
similarity index 98%
copy from arch/arm/boot/dts/dra74x.dtsi
copy to arch/arm/boot/dts/dra74x-common.dtsi
index 8294a607fec8..401b4af65397 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x-common.dtsi
@@ -10,8 +10,6 @@
 #include "dra7.dtsi"
 
 / {
-	compatible = "ti,dra742", "ti,dra74", "ti,dra7";
-
 	cpus {
 		cpu@1 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 8294a607fec8..5c40bf894f44 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -1,148 +1,7 @@
-/*
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- * Based on "omap4.dtsi"
- */
+#include "dra74x-common.dtsi"
+#include "dra7-l4-jacinto.dtsi"
 
-#include "dra7.dtsi"
 
 / {
-	compatible = "ti,dra742", "ti,dra74", "ti,dra7";
-
-	cpus {
-		cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <1>;
-			operating-points-v2 = <&cpu0_opp_table>;
-
-			clocks = <&dpll_mpu_ck>;
-			clock-names = "cpu";
-
-			clock-latency = <300000>; /* From omap-cpufreq driver */
-
-			/* cooling options */
-			#cooling-cells = <2>; /* min followed by max */
-
-			vbb-supply = <&abb_mpu>;
-		};
-	};
-
-	pmu {
-		compatible = "arm,cortex-a15-pmu";
-		interrupt-parent = <&wakeupgen>;
-		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	ocp {
-		dsp2_system: dsp_system@41500000 {
-			compatible = "syscon";
-			reg = <0x41500000 0x100>;
-		};
-
-		omap_dwc3_4: omap_dwc3_4@48940000 {
-			compatible = "ti,dwc3";
-			ti,hwmods = "usb_otg_ss4";
-			reg = <0x48940000 0x10000>;
-			interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			utmi-mode = <2>;
-			ranges;
-			status = "disabled";
-			usb4: usb@48950000 {
-				compatible = "snps,dwc3";
-				reg = <0x48950000 0x17000>;
-				interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "peripheral",
-						  "host",
-						  "otg";
-				maximum-speed = "high-speed";
-				dr_mode = "otg";
-			};
-		};
-
-		mmu0_dsp2: mmu@41501000 {
-			compatible = "ti,dra7-dsp-iommu";
-			reg = <0x41501000 0x100>;
-			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "mmu0_dsp2";
-			#iommu-cells = <0>;
-			ti,syscon-mmuconfig = <&dsp2_system 0x0>;
-			status = "disabled";
-		};
-
-		mmu1_dsp2: mmu@41502000 {
-			compatible = "ti,dra7-dsp-iommu";
-			reg = <0x41502000 0x100>;
-			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
-			ti,hwmods = "mmu1_dsp2";
-			#iommu-cells = <0>;
-			ti,syscon-mmuconfig = <&dsp2_system 0x1>;
-			status = "disabled";
-		};
-	};
-};
-
-&cpu0_opp_table {
-	opp-shared;
-};
-
-&dss {
-	reg = <0x58000000 0x80>,
-	      <0x58004054 0x4>,
-	      <0x58004300 0x20>,
-	      <0x58009054 0x4>,
-	      <0x58009300 0x20>;
-	reg-names = "dss", "pll1_clkctrl", "pll1",
-		    "pll2_clkctrl", "pll2";
-
-	clocks = <&dss_clkctrl DRA7_DSS_DSS_CORE_CLKCTRL 8>,
-		 <&dss_clkctrl DRA7_DSS_DSS_CORE_CLKCTRL 12>,
-		 <&dss_clkctrl DRA7_DSS_DSS_CORE_CLKCTRL 13>;
-	clock-names = "fck", "video1_clk", "video2_clk";
-};
-
-&mailbox5 {
-	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
-		ti,mbox-tx = <6 2 2>;
-		ti,mbox-rx = <4 2 2>;
-		status = "disabled";
-	};
-	mbox_dsp1_ipc3x: mbox_dsp1_ipc3x {
-		ti,mbox-tx = <5 2 2>;
-		ti,mbox-rx = <1 2 2>;
-		status = "disabled";
-	};
-};
-
-&mailbox6 {
-	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
-		ti,mbox-tx = <6 2 2>;
-		ti,mbox-rx = <4 2 2>;
-		status = "disabled";
-	};
-	mbox_dsp2_ipc3x: mbox_dsp2_ipc3x {
-		ti,mbox-tx = <5 2 2>;
-		ti,mbox-rx = <1 2 2>;
-		status = "disabled";
-	};
-};
-
-&pcie1_rc {
-	compatible = "ti,dra746-pcie-rc", "ti,dra7-pcie";
-};
-
-&pcie1_ep {
-	compatible = "ti,dra746-pcie-ep", "ti,dra7-pcie-ep";
-};
-
-&pcie2_rc {
-	compatible = "ti,dra746-pcie-rc", "ti,dra7-pcie";
+        compatible = "ti,dra742", "ti,dra74", "ti,dra7";
 };
diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x-common.dtsi
similarity index 98%
copy from arch/arm/boot/dts/dra76x.dtsi
copy to arch/arm/boot/dts/dra76x-common.dtsi
index 9ee45aa365d8..caaf07f98d76 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x-common.dtsi
@@ -9,8 +9,6 @@
 #include "dra74x.dtsi"
 
 / {
-	compatible = "ti,dra762", "ti,dra7";
-
 	ocp {
 		target-module@42c01900 {
 			compatible = "ti,sysc-dra7-mcan", "ti,sysc";
diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index 9ee45aa365d8..7d77e30bc7f8 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -1,83 +1,6 @@
-/*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include "dra74x.dtsi"
+#include "dra76x-common.dtsi"
+#include "dra7-l4-jacinto.dtsi"
 
 / {
 	compatible = "ti,dra762", "ti,dra7";
-
-	ocp {
-		target-module@42c01900 {
-			compatible = "ti,sysc-dra7-mcan", "ti,sysc";
-			ranges = <0x0 0x42c00000 0x2000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x42c01900 0x4>,
-			      <0x42c01904 0x4>,
-			      <0x42c01908 0x4>;
-			reg-names = "rev", "sysc", "syss";
-			ti,sysc-mask = <(SYSC_OMAP4_SOFTRESET |
-					 SYSC_DRA7_MCAN_ENAWAKEUP)>;
-			ti,syss-mask = <1>;
-			clocks = <&wkupaon_clkctrl DRA7_WKUPAON_ADC_CLKCTRL 0>;
-			clock-names = "fck";
-
-			m_can0: mcan@1a00 {
-				compatible = "bosch,m_can";
-				reg = <0x1a00 0x4000>, <0x0 0x18FC>;
-				reg-names = "m_can", "message_ram";
-				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "int0", "int1";
-				clocks = <&mcan_clk>, <&l3_iclk_div>;
-				clock-names = "cclk", "hclk";
-				bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
-			};
-		};
-	};
-
-};
-
-/* MCAN interrupts are hard-wired to irqs 67, 68 */
-&crossbar_mpu {
-	ti,irqs-skip = <10 67 68 133 139 140>;
-};
-
-&scm_conf_clocks {
-	dpll_gmac_h14x2_ctrl_ck: dpll_gmac_h14x2_ctrl_ck@3fc {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&dpll_gmac_x2_ck>;
-		ti,max-div = <63>;
-		reg = <0x03fc>;
-		ti,bit-shift=<20>;
-		ti,latch-bit=<26>;
-		assigned-clocks = <&dpll_gmac_h14x2_ctrl_ck>;
-		assigned-clock-rates = <80000000>;
-	};
-
-	dpll_gmac_h14x2_ctrl_mux_ck: dpll_gmac_h14x2_ctrl_mux_ck@3fc {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dpll_gmac_ck>, <&dpll_gmac_h14x2_ctrl_ck>;
-		reg = <0x3fc>;
-		ti,bit-shift = <29>;
-		ti,latch-bit=<26>;
-		assigned-clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
-		assigned-clock-parents = <&dpll_gmac_h14x2_ctrl_ck>;
-	};
-
-	mcan_clk: mcan_clk@3fc {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
-		ti,bit-shift = <27>;
-		reg = <0x3fc>;
-	};
 };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
