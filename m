Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF10C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9810C20665
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OxggvS07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfE2JT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:19:56 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54898 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2JTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:19:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4T9JifF009253;
        Wed, 29 May 2019 04:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559121584;
        bh=+xTE10V8aohxT+Kq0AQML6/+dZPD7lAi9/07SdRegaY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OxggvS07d1QGnNPKT2xbYCr3tGN+bMA8m0Ihxjwyo40LB1Hp+asIBeUbURCPcRF8Z
         DH90Bn7NhVBADXtAYfHCm2BTzSKq6KD92ix/tcDxUiVYJx/g8pTPwGCsHh2fCbxitC
         +O+hccVq9rrguRi5XWooDJ0TqFlA7Oxkxu/YIcFA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4T9JiUl032612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 May 2019 04:19:44 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 29
 May 2019 04:19:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 29 May 2019 04:19:44 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4T9JVxQ079377;
        Wed, 29 May 2019 04:19:42 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/6] arm64: dts: k3-am6: Add SERDES DT node
Date:   Wed, 29 May 2019 14:48:09 +0530
Message-ID: <20190529091812.20764-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529091812.20764-1-kishon@ti.com>
References: <20190529091812.20764-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for SERDES0 and SERDES1.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 99d2402455d1..443de60576f8 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
  */
+#include <dt-bindings/phy/phy-am654-serdes.h>
 
 &cbass_main {
 	msmc_ram: sram@70000000 {
@@ -61,6 +62,36 @@
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	serdes0: serdes@900000 {
+		compatible = "ti,phy-am654-serdes";
+		reg = <0x0 0x900000 0x0 0x2000>;
+		reg-names = "serdes";
+		#phy-cells = <2>;
+		power-domains = <&k3_pds 153>;
+		clocks = <&k3_clks 153 4>, <&k3_clks 153 1>, <&serdes1 AM654_SERDES_LO_REFCLK>;
+		clock-output-names = "serdes0_cmu_refclk", "serdes0_lo_refclk", "serdes0_ro_refclk";
+		assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
+		assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
+		ti,serdes-clk = <&serdes0_clk>;
+		#clock-cells = <1>;
+		mux-controls = <&serdes_mux 0>;
+	};
+
+	serdes1: serdes@910000 {
+		compatible = "ti,phy-am654-serdes";
+		reg = <0x0 0x910000 0x0 0x2000>;
+		reg-names = "serdes";
+		#phy-cells = <2>;
+		power-domains = <&k3_pds 154>;
+		clocks = <&serdes0 AM654_SERDES_RO_REFCLK>, <&k3_clks 154 1>, <&k3_clks 154 5>;
+		clock-output-names = "serdes1_cmu_refclk", "serdes1_lo_refclk", "serdes1_ro_refclk";
+		assigned-clocks = <&k3_clks 154 5>, <&serdes1 AM654_SERDES_CMU_REFCLK>;
+		assigned-clock-parents = <&k3_clks 154 9>, <&k3_clks 154 5>;
+		ti,serdes-clk = <&serdes1_clk>;
+		#clock-cells = <1>;
+		mux-controls = <&serdes_mux 1>;
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
@@ -234,6 +265,16 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
+		serdes0_clk: serdes_clk@4080 {
+			compatible = "syscon";
+			reg = <0x00004080 0x4>;
+		};
+
+		serdes1_clk: serdes_clk@4090 {
+			compatible = "syscon";
+			reg = <0x00004090 0x4>;
+		};
+
 		serdes_mux: mux-controller {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
-- 
2.17.1

