Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98988CA9EC5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724F420663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfJ2L2A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:28:00 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:49830 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfJ2L17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:27:59 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 1ADFB702C01;
        Tue, 29 Oct 2019 12:27:55 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 29 Oct
 2019 12:27:54 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 29 Oct 2019 12:27:54 +0100
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
Subject: [PATCH v2 04/11] ARM: dts: Add support for two more Kontron evalkit
 boards 'N6311 S' and 'N6411 S'
Thread-Topic: [PATCH v2 04/11] ARM: dts: Add support for two more Kontron
 evalkit boards 'N6311 S' and 'N6411 S'
Thread-Index: AQHVjkvoL0/HMWdhEEqeweaeEsCATQ==
Date:   Tue, 29 Oct 2019 11:27:54 +0000
Message-ID: <20191029112655.15058-5-frieder.schrempf@kontron.de>
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
X-SnT-MailScanner-ID: 1ADFB702C01.AE78E
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

The 'N6311 S' and the 'N6411 S' are similar to the Kontron 'N6310 S'
evaluation kit boards. Instead of the N6310 SoM, they feature a N6311
or N6411 SoM.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts  | 16 ++++++++++++++++
 arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts

diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts b/arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
new file mode 100644
index 000000000000..239a1af3aeaa
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (C) 2018 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include "imx6ul-kontron-n6311-som.dtsi"
+#include "imx6ul-kontron-n6x1x-s.dtsi"
+
+/ {
+	model = "Kontron N6311 S";
+	compatible = "kontron,imx6ul-n6311-s", "kontron,imx6ul-n6311-som",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts b/arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts
new file mode 100644
index 000000000000..57588a5e1e34
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include "imx6ull-kontron-n6411-som.dtsi"
+#include "imx6ul-kontron-n6x1x-s.dtsi"
+
+/ {
+	model = "Kontron N6411 S";
+	compatible = "kontron,imx6ull-n6411-s", "kontron,imx6ull-n6411-som",
+		     "fsl,imx6ull";
+};
-- 
2.17.1
