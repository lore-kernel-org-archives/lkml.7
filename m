Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D70C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F137A2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="owxkauXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfE2JUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:20:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39722 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2JT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:19:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4T9JmQD010006;
        Wed, 29 May 2019 04:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559121588;
        bh=SnNDdZO8f1mZszMzppiz05NBYAG7PY4/O0tZ3qXbBwo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=owxkauXfO/r5ux0jSFnu45Hwrf7olLgUiv2HMl5LggOn0R33Sp8ecsN1NPY9BlDLu
         A8+jZy2w2W9GzOmD9CM1iMuuU7LIZkZqy3W1CbIo1IeIHJbNcwt8He7KMUeXheIqxT
         jGjTqeeI2CYKpZH63gh26zIKMn2OphKmSxyoVbxI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4T9JlB9050484
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 May 2019 04:19:47 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 29
 May 2019 04:19:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 29 May 2019 04:19:47 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4T9JVxR079377;
        Wed, 29 May 2019 04:19:45 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4/6] arm64: dts: k3-am6: Add PCIe Root Complex DT node
Date:   Wed, 29 May 2019 14:48:10 +0530
Message-ID: <20190529091812.20764-5-kishon@ti.com>
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

Add PCIe Root Complex DT node.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 53 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi      |  1 +
 2 files changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 443de60576f8..09f18b1e70f2 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -265,6 +265,21 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
+		pcie0_mode: pcie-mode@4060 {
+			compatible = "syscon";
+			reg = <0x00004060 0x4>;
+		};
+
+		pcie1_mode: pcie-mode@4070 {
+			compatible = "syscon";
+			reg = <0x00004070 0x4>;
+		};
+
+		pcie_devid: pcie-devid@210 {
+			compatible = "syscon";
+			reg = <0x00000210 0x4>;
+		};
+
 		serdes0_clk: serdes_clk@4080 {
 			compatible = "syscon";
 			reg = <0x00004080 0x4>;
@@ -358,4 +373,42 @@
 		clock-names = "wkupclk", "refclk";
 		#phy-cells = <0>;
 	};
+
+	pcie0_rc: pcie@5500000 {
+		compatible = "ti,am654-pcie-rc";
+		reg =  <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x2000>, <0x0 0x5506000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu";
+		power-domains = <&k3_pds 120>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000
+			  0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
+		ti,syscon-pcie-id = <&pcie_devid>;
+		ti,syscon-pcie-mode = <&pcie0_mode>;
+		bus-range = <0x0 0xff>;
+		num-viewport = <16>;
+		max-link-speed = <3>;
+		dma-coherent;
+		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+	};
+
+	pcie1_rc: pcie@5600000 {
+		compatible = "ti,am654-pcie-rc";
+		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu";
+		power-domains = <&k3_pds 121>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x81000000 0 0          0x0   0x18020000 0 0x00010000
+			  0x82000000 0 0x18030000 0x0   0x18030000 0 0x07FD0000>;
+		ti,syscon-pcie-id = <&pcie_devid>;
+		ti,syscon-pcie-mode = <&pcie1_mode>;
+		bus-range = <0x0 0xff>;
+		num-viewport = <16>;
+		max-link-speed = <3>;
+		dma-coherent;
+		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
+		msi-map = <0x0 &gic_its 0x10000 0x10000>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index 50f4be2047a9..5a021321d4ed 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -68,6 +68,7 @@
 			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
 			 <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>, /* MAIN NAVSS */
+			 <0x00 0x10000000 0x00 0x10000000 0x00 0x10000000>, /* PCIe DAT */
 			 /* MCUSS Range */
 			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
 			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00900100>,
-- 
2.17.1

