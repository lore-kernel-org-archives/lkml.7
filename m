Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6072C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7195F20881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fhNn1wp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfEVQVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:21:08 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45622 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfEVQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:21:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4MGKd5N073728;
        Wed, 22 May 2019 11:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558542039;
        bh=QXG5XFuSCA/eKjm6eAz/ccN4peIXTQp3/Ud3QfKb6II=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fhNn1wp8crWYJ6iDZgNwO2GuexbMHyGTxN8IiSUFy8sFhz/W+eLyLpWbXp/9wM7PD
         7uKO72YIa5m2NnVkv/CA4AtRbukV8LigCUVocLtBPLDRRG9YM6AfRiB3njXUVZRqQW
         e8SD7cNCyG1sgQRmF4WGED8BCsB5CAHINy1VJduM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4MGKdcQ103304
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 May 2019 11:20:39 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 22
 May 2019 11:20:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 22 May 2019 11:20:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4MGKc2P122874;
        Wed, 22 May 2019 11:20:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/6] arm64: dts: ti: Add support for J721E Common Processor Board
Date:   Wed, 22 May 2019 11:19:20 -0500
Message-ID: <20190522161921.20750-6-nm@ti.com>
X-Mailer: git-send-email 2.21.0.777.g83232e38648b
In-Reply-To: <20190522161921.20750-1-nm@ti.com>
References: <20190522161921.20750-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for J721E Common Processor board support.
The EVM architecture is as follows:

+------------------------------------------------------+
|   +-------------------------------------------+      |
|   |                                           |      |
|   |        Add-on Card 1 Options              |      |
|   |                                           |      |
|   +-------------------------------------------+      |
|                                                      |
|                                                      |
|                     +-------------------+            |
|                     |                   |            |
|                     |   SOM             |            |
|  +--------------+   |                   |            |
|  |              |   |                   |            |
|  |  Add-on      |   +-------------------+            |
|  |  Card 2      |                                    |    Power Supply
|  |  Options     |                                    |    |
|  |              |                                    |    |
|  +--------------+                                    | <---
+------------------------------------------------------+
                                Common Processor Board

Common Processor board is the baseboard that has most of the actual
connectors, power supply etc. A SOM (System on Module) is plugged on
to the common processor board and this contains the SoC, PMIC, DDR and
basic high speed components necessary for functionality. Add-n card
options add further functionality (such as additional Audio, Display,
networking options).

Note:
A) The minimum configuration required to boot up the board is System On
   Module(SOM) + Common Processor Board.
B) Since there is just a single SOM and Common Processor Board, we are
   maintaining common processor board as the base dts and SOM as the dtsi
   that we include. In the future as more SOM's appear, we should move
   common processor board as a dtsi and include configurations as dts.
C) All daughter cards beyond the basic boards shall be maintained as
   overlays.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-j721e-common-proc-board.dts     | 50 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 29 +++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 63e619d0b5b8..b397945fdf73 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -7,3 +7,5 @@
 #
 
 dtb-$(CONFIG_ARCH_K3_AM6_SOC) += k3-am654-base-board.dtb
+
+dtb-$(CONFIG_ARCH_K3_J721E_SOC) += k3-j721e-common-proc-board.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
new file mode 100644
index 000000000000..c680123f067c
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-j721e-som-p0.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial2:115200n8";
+		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
+	};
+};
+
+&wkup_uart0 {
+	/* Wakeup UART is used by System firmware */
+	status = "disabled";
+};
+
+&main_uart3 {
+	/* UART not brought out */
+	status = "disabled";
+};
+
+&main_uart5 {
+	/* UART not brought out */
+	status = "disabled";
+};
+
+&main_uart6 {
+	/* UART not brought out */
+	status = "disabled";
+};
+
+&main_uart7 {
+	/* UART not brought out */
+	status = "disabled";
+};
+
+&main_uart8 {
+	/* UART not brought out */
+	status = "disabled";
+};
+
+&main_uart9 {
+	/* UART not brought out */
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
new file mode 100644
index 000000000000..1884fc70148f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-j721e.dtsi"
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		/* 4G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+};
-- 
2.21.0.777.g83232e38648b

