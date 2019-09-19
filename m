Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E6EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD57206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r/eiX4mR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbfISPcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:32:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50454 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391251AbfISPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:32:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8JFW5T4130052;
        Thu, 19 Sep 2019 10:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568907125;
        bh=hgi52LcBYsdTA/OSGmQd/vP08szJy4H/8TwnILemHJg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=r/eiX4mR14TABN4He5IssAQkU/3y65ZVa9U5d5p3PtUQxg15VfswfvqfUdXDTm3PT
         3pipG94yIBqRFxQoNM/JLgtVuNymWzdkE+g5uDEvVkqoW1J4xx6oVI6+6eDKdFCcTs
         JyulpnEHnRKeKyE1QzyqrSbJ8HC2yYKdlqi8TbJU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8JFW5CL009562;
        Thu, 19 Sep 2019 10:32:05 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 19
 Sep 2019 10:32:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 19 Sep 2019 10:32:01 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8JFVxwL001224;
        Thu, 19 Sep 2019 10:32:02 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: j721e-main: Add SDHCI nodes
Date:   Thu, 19 Sep 2019 21:02:41 +0530
Message-ID: <20190919153242.29399-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190919153242.29399-1-faiz_abbas@ti.com>
References: <20190919153242.29399-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the 3 SDHCI instances present on TI's J721E device.
instance 0 supports HS400 (8 bit bus widht, DDR, 400 MBps)
while instances 1 and 2 support SDR104 (4 bit width, SDR, 100 MBps) as
their highest speed modes. Currently, only High speed (50 MHz clock) has
been enabled.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 199bc9a00b20..1650bbd10932 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -372,4 +372,54 @@
 		clocks = <&k3_clks 112 0>;
 		clock-names = "gpio";
 	};
+
+	main_sdhci0: sdhci@4f80000 {
+		compatible = "ti,j721e-sdhci-8bit";
+		reg = <0x0 0x4f80000 0x0 0x1000>, <0x0 0x4f88000 0x0 0x400>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&k3_clks 91 1>, <&k3_clks 91 0>;
+		assigned-clocks = <&k3_clks 91 1>;
+		assigned-clock-parents = <&k3_clks 91 2>;
+		bus-width = <8>;
+		mmc-hs400-1_8v;
+		mmc-ddr-1_8v;
+		ti,otap-del-sel = <0x2>;
+		ti,trm-icp = <0x8>;
+		ti,strobe-sel = <0x77>;
+		dma-coherent;
+	};
+
+	main_sdhci1: sdhci@4fb0000 {
+		compatible = "ti,j721e-sdhci-4bit";
+		reg = <0x0 0x04fb0000 0x0 0x1000>, <0x0 0x4fb8000 0x0 0x400>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 92 TI_SCI_PD_EXCLUSIVE>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&k3_clks 92 0>, <&k3_clks 92 5>;
+		assigned-clocks = <&k3_clks 92 0>;
+		assigned-clock-parents = <&k3_clks 92 1>;
+		ti,otap-del-sel = <0x2>;
+		ti,trm-icp = <0x8>;
+		ti,clkbuf-sel = <0x7>;
+		dma-coherent;
+		no-1-8-v;
+	};
+
+	main_sdhci2: sdhci@4f98000 {
+		compatible = "ti,j721e-sdhci-4bit";
+		reg = <0x0 0x4f98000 0x0 0x1000>, <0x0 0x4f90000 0x0 0x400>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 93 TI_SCI_PD_EXCLUSIVE>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&k3_clks 93 0>, <&k3_clks 93 5>;
+		assigned-clocks = <&k3_clks 93 0>;
+		assigned-clock-parents = <&k3_clks 93 1>;
+		ti,otap-del-sel = <0x2>;
+		ti,trm-icp = <0x8>;
+		ti,clkbuf-sel = <0x7>;
+		dma-coherent;
+		no-1-8-v;
+	};
 };
-- 
2.19.2

