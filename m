Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF054C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F85206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cj0HLS4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfG1Tw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 15:52:28 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:39622 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1Tw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564343545; x=1595879545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lnBq3HvLJN7Il2FzK5LtTNKLFpA92Bs08tgDB+EdNWg=;
  b=cj0HLS4ZiIY+JuAVxpHb3Zyxs2naSmlO4JSYqSaGFG2cfvgdzXuHg1mX
   smrgJe6M1ppMMVzy//8WwEaPPTBpRybUPoqRtpTNdx4V2fBOlffBWjEVo
   8DNFuFjLHapwR3kR0y6jJ2xeRNdrtmib6KLAzQBYL6Ty3g/BxJOG8rvNr
   w=;
X-IronPort-AV: E=Sophos;i="5.64,319,1559520000"; 
   d="scan'208";a="412722413"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 28 Jul 2019 19:52:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id A0493A2173;
        Sun, 28 Jul 2019 19:52:22 +0000 (UTC)
Received: from EX13D05EUC002.ant.amazon.com (10.43.164.231) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 28 Jul 2019 19:52:22 +0000
Received: from u18dbf258377358bea500.amazon.com (10.43.160.25) by
 EX13D05EUC002.ant.amazon.com (10.43.164.231) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 28 Jul 2019 19:52:13 +0000
From:   Ronen Krupnik <ronenk@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <barakw@amazon.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <jonnyc@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <hanochu@amazon.com>, Ronen Krupnik <ronenk@amazon.com>
Subject: [PATCH 2/2] arm64: dts: amazon: add Amazon Annapurna Labs Alpine v3 support
Date:   Sun, 28 Jul 2019 22:51:35 +0300
Message-ID: <20190728195135.12661-3-ronenk@amazon.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190728195135.12661-1-ronenk@amazon.com>
References: <20190728195135.12661-1-ronenk@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.25]
X-ClientProxiedBy: EX13P01UWA002.ant.amazon.com (10.43.160.46) To
 EX13D05EUC002.ant.amazon.com (10.43.164.231)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the initial support for the Amazon Annapurna Labs Alpine v3
Soc and Evaluation Platform (EVP).

Signed-off-by: Ronen Krupnik <ronenk@amazon.com>
---
 arch/arm64/boot/dts/Makefile                 |   1 +
 arch/arm64/boot/dts/amazon/Makefile          |   1 +
 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts |  23 ++
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi    | 371 +++++++++++++++++++
 4 files changed, 396 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amazon/Makefile
 create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
 create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 4690364d584b..25b750f147d2 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -3,6 +3,7 @@ subdir-y += actions
 subdir-y += al
 subdir-y += allwinner
 subdir-y += altera
+subdir-y += amazon
 subdir-y += amd
 subdir-y += amlogic
 subdir-y += apm
diff --git a/arch/arm64/boot/dts/amazon/Makefile b/arch/arm64/boot/dts/amazon/Makefile
new file mode 100644
index 000000000000..d71ac87172eb
--- /dev/null
+++ b/arch/arm64/boot/dts/amazon/Makefile
@@ -0,0 +1 @@
+dtb-$(CONFIG_ARCH_ALPINE)	+= alpine-v3-evp.dtb
diff --git a/arch/arm64/boot/dts/amazon/alpine-v3-evp.dts b/arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
new file mode 100644
index 000000000000..542e3d419904
--- /dev/null
+++ b/arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include "alpine-v3.dtsi"
+
+/ {
+	model = "Amazon Alpine v3 Evaluation Platform (EVP)";
+	compatible = "amazon,alpine-v3-evp", "amazon,alpine-v3";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
new file mode 100644
index 000000000000..dd91d86ec486
--- /dev/null
+++ b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019, Amazon.com, Inc. or its affiliates. All Rights Reserved
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "Amazon Alpine v3";
+	compatible = "amazon,alpine-v3";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x0>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x1>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x2>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x3>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x100>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x101>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x102>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x103>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x200>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x201>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@202 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x202>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@203 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x203>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x300>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x301>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@302 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x302>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@303 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x303>;
+			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cluster0_l2: cache@0 {
+			compatible = "cache";
+			cache-size = <0x200000>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
+			cache-level = <2>;
+		};
+
+		cluster1_l2: cache@100 {
+			compatible = "cache";
+			cache-size = <0x200000>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
+			cache-level = <2>;
+		};
+
+		cluster2_l2: cache@200 {
+			compatible = "cache";
+			cache-size = <0x200000>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
+			cache-level = <2>;
+		};
+
+		cluster3_l2: cache@300 {
+			compatible = "cache";
+			cache-size = <0x200000>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
+			cache-level = <2>;
+		};
+
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secmon@0 {
+			reg = <0x0 0x0 0x0 0x100000>;
+			no-map;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		interrupt-parent = <&gic>;
+		ranges;
+
+		arch-timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 0xd IRQ_TYPE_LEVEL_LOW
+				      GIC_PPI 0xe IRQ_TYPE_LEVEL_LOW
+				      GIC_PPI 0xb IRQ_TYPE_LEVEL_LOW
+				      GIC_PPI 0xa IRQ_TYPE_LEVEL_LOW>;
+		};
+
+		gic: interrupt-controller@f0000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#size-cells = <0>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xf0800000 0 0x10000>,
+			      <0x0 0xf0a00000 0 0x200000>,
+			      <0x0 0xf0000000 0 0x2000>,
+			      <0x0 0xf0010000 0 0x1000>,
+			      <0x0 0xf0020000 0 0x2000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		msix: msix@fbe00000 {
+			compatible = "al,alpine-msix";
+			reg = <0x0 0xfbe00000 0x0 0x100000>;
+			interrupt-controller;
+			msi-controller;
+			al,msi-base-spi = <160>;
+			al,msi-num-spis = <800>;
+			interrupt-parent = <&gic>;
+		};
+
+		pmu {
+			compatible = "arm,armv8-pmuv3";
+			interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		uart0: serial@fd883000 {
+			compatible = "ns16550a";
+			device_type = "serial";
+			reg = <0x0 0xfd883000 0x0 0x1000>;
+			clock-frequency = <0>; /* filled by uboot */
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		pci@fbd00000 {
+			compatible = "pci-host-ecam-generic";
+			device_type = "pci";
+			#size-cells = <2>;
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			reg = <0x0 0xfbd00000 0x0 0x100000>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			/* 8 x legacy interrupts for SATA only */
+			interrupt-map = <0x4000 0 0 1 &gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
+					<0x4800 0 0 1 &gic 0 58 IRQ_TYPE_LEVEL_HIGH>,
+					<0x5000 0 0 1 &gic 0 59 IRQ_TYPE_LEVEL_HIGH>,
+					<0x5800 0 0 1 &gic 0 60 IRQ_TYPE_LEVEL_HIGH>,
+					<0x6000 0 0 1 &gic 0 61 IRQ_TYPE_LEVEL_HIGH>,
+					<0x6800 0 0 1 &gic 0 62 IRQ_TYPE_LEVEL_HIGH>,
+					<0x7000 0 0 1 &gic 0 63 IRQ_TYPE_LEVEL_HIGH>,
+					<0x7800 0 0 1 &gic 0 64 IRQ_TYPE_LEVEL_HIGH>;
+			ranges = <0x02000000 0x0 0xfe000000 0x0 0xfe000000 0x0 0x1000000>;
+			bus-range = <0x00 0x00>;
+		};
+	};
+};
-- 
2.21.0

