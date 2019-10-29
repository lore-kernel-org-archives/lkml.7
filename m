Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94324CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69982214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfJ2L2L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:28:11 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:49916 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbfJ2L2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:28:10 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id B7B2E73EDAA;
        Tue, 29 Oct 2019 12:28:07 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 29 Oct
 2019 12:28:07 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 29 Oct 2019 12:28:07 +0100
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
Subject: [PATCH v2 08/11] ARM: dts: imx6ul-kontron-n6x1x-s: Remove an obsolete
 comment and fix indentation
Thread-Topic: [PATCH v2 08/11] ARM: dts: imx6ul-kontron-n6x1x-s: Remove an
 obsolete comment and fix indentation
Thread-Index: AQHVjkvvG/OJKetZEEClPJ8BNJG6Ow==
Date:   Tue, 29 Oct 2019 11:28:07 +0000
Message-ID: <20191029112655.15058-9-frieder.schrempf@kontron.de>
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
X-SnT-MailScanner-ID: B7B2E73EDAA.A461D
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

The ECSPI1 is not used for a FRAM chip, so remove the comment.
While at it, also change some whitespaces to tabs to comply with the
indentation style of the rest of the file.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
index d3eb21aa9014..e18a8bd239be 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
@@ -256,7 +256,6 @@
 		>;
 	};
 
-	/* FRAM */
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
 			MX6UL_PAD_CSI_DATA07__ECSPI1_MISO	0x100b1
@@ -281,8 +280,8 @@
 
 	pinctrl_enet2_mdio: enet2mdiogrp {
 		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO07__ENET2_MDC         0x1b0b0
-			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO        0x1b0b0
+			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
 		>;
 	};
 
@@ -295,10 +294,10 @@
 
 	pinctrl_gpio: gpiogrp {
 		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0 /* DOUT1 */
-			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0 /* DIN1 */
-			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x1b0b0 /* DOUT2 */
-			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0 /* DIN2 */
+			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0	/* DOUT1 */
+			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0	/* DIN1 */
+			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x1b0b0	/* DOUT2 */
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0	/* DIN2 */
 		>;
 	};
 
-- 
2.17.1
