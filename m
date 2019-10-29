Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F64CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755FA21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfJ2L1x convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:27:53 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:45580 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfJ2L1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:27:52 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id CD0BA60CF47;
        Tue, 29 Oct 2019 12:27:48 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 29 Oct
 2019 12:27:48 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 29 Oct 2019 12:27:48 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/11] ARM: dts: Add support for two more Kontron SoMs
 N6311 and N6411
Thread-Topic: [PATCH v2 02/11] ARM: dts: Add support for two more Kontron SoMs
 N6311 and N6411
Thread-Index: AQHVjkvkakPcKv/ZJEeuGhqjra0hXQ==
Date:   Tue, 29 Oct 2019 11:27:48 +0000
Message-ID: <20191029112655.15058-3-frieder.schrempf@kontron.de>
References: <20191029112655.15058-1-frieder.schrempf@kontron.de>
In-Reply-To: <20191029112655.15058-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: CD0BA60CF47.A1C10
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The N6311 and the N6411 SoM are similar to the Kontron N6310 SoM.
They are pin-compatible, but feature a larger RAM and NAND flash
(512MiB instead of 256MiB). Further, the N6411 has an i.MX6ULL SoC,
instead of an i.MX6UL.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/imx6ul-kontron-n6311-som.dtsi    | 40 +++++++++++++++++++
 .../boot/dts/imx6ull-kontron-n6411-som.dtsi   | 40 +++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
new file mode 100644
index 000000000000..a095a7654ac6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (C) 2018 Kontron Electronics GmbH
+ */
+
+#include "imx6ul.dtsi"
+#include "imx6ul-kontron-n6x1x-som-common.dtsi"
+
+/ {
+	model = "Kontron N6311 SOM";
+	compatible = "kontron,imx6ul-n6311-som", "fsl,imx6ul";
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+		device_type = "memory";
+	};
+};
+
+&qspi {
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spi-nand";
+		spi-max-frequency = <104000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		reg = <0>;
+
+		partition@0 {
+			label = "ubi1";
+			reg = <0x00000000 0x08000000>;
+		};
+
+		partition@8000000 {
+			label = "ubi2";
+			reg = <0x08000000 0x18000000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi b/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
new file mode 100644
index 000000000000..b7e984284e1a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (C) 2018 Kontron Electronics GmbH
+ */
+
+#include "imx6ull.dtsi"
+#include "imx6ul-kontron-n6x1x-som-common.dtsi"
+
+/ {
+	model = "Kontron N6411 SOM";
+	compatible = "kontron,imx6ull-n6311-som", "fsl,imx6ull";
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+		device_type = "memory";
+	};
+};
+
+&qspi {
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spi-nand";
+		spi-max-frequency = <104000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		reg = <0>;
+
+		partition@0 {
+			label = "ubi1";
+			reg = <0x00000000 0x08000000>;
+		};
+
+		partition@8000000 {
+			label = "ubi2";
+			reg = <0x08000000 0x18000000>;
+		};
+	};
+};
-- 
2.17.1
