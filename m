Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD60C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC94206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="amFnToyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391339AbfISPcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:32:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60634 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389531AbfISPcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:32:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8JFW7Gi069912;
        Thu, 19 Sep 2019 10:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568907127;
        bh=NO4p9MHndcp9v50S+FZAaHmSvojyoT1ZHqA7E8UIydA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=amFnToyivha5/S3V+sgDW3hV+ni0A/DKC764wu0IN0xihWtZvydcy94nDqgN7WFmJ
         Qzez5sOk8aIjV++N4LL9coGboap5NBhfyKi6a8AAT/lXstjhMUsHlYtygWrwmgkyx2
         oIbruxGQKCwvsAGURoaUZv+v1/KoXPeAtWpNzj28=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8JFW72x009614;
        Thu, 19 Sep 2019 10:32:07 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 19
 Sep 2019 10:32:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 19 Sep 2019 10:32:03 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8JFVxwM001224;
        Thu, 19 Sep 2019 10:32:05 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: j721e-common-proc-board: Add Support for eMMC and SD card
Date:   Thu, 19 Sep 2019 21:02:42 +0530
Message-ID: <20190919153242.29399-3-faiz_abbas@ti.com>
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

sdhci0 is connected to an eMMC and sdhci1 is connected to an SD card
slot. Add support for these nodes.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index d2894d55fbbe..3cfaa2c83ba6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -41,6 +41,20 @@
 			J721E_IOPAD(0x0, PIN_INPUT, 7) /* (AC18) EXTINTn.GPIO0_0 */
 		>;
 	};
+
+	main_mmc1_pins_default: main_mmc1_pins_default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x254, PIN_INPUT, 0) /* (R29) MMC1_CMD */
+			J721E_IOPAD(0x250, PIN_INPUT, 0) /* (P25) MMC1_CLK */
+			J721E_IOPAD(0x2ac, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
+			J721E_IOPAD(0x24c, PIN_INPUT, 0) /* (R24) MMC1_DAT0 */
+			J721E_IOPAD(0x248, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
+			J721E_IOPAD(0x244, PIN_INPUT, 0) /* (R25) MMC1_DAT2 */
+			J721E_IOPAD(0x240, PIN_INPUT, 0) /* (R26) MMC1_DAT3 */
+			J721E_IOPAD(0x258, PIN_INPUT, 0) /* (P23) MMC1_SDCD */
+			J721E_IOPAD(0x25c, PIN_INPUT, 0) /* (R28) MMC1_SDWP */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -117,3 +131,23 @@
 &wkup_gpio1 {
 	status = "disabled";
 };
+
+&main_sdhci0 {
+	/* eMMC */
+	non-removable;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&main_sdhci1 {
+	/* SD/MMC */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&main_sdhci2 {
+	/* Unused */
+	status = "disabled";
+};
-- 
2.19.2

