Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B3CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802CC20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbfG3O6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:58:33 -0400
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:35765 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731626AbfG3O6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:58:31 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.92 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsTa9-000FsZ-8w; Tue, 30 Jul 2019 16:58:29 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsTP8-000Mva-Db; Tue, 30 Jul 2019 16:47:06 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        stefan@agner.ch, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 18/22] ARM: dts: imx6ull-colibri: Add watchdog
Date:   Tue, 30 Jul 2019 16:46:45 +0200
Message-Id: <20190730144649.19022-19-dev@pschenker.ch>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730144649.19022-1-dev@pschenker.ch>
References: <20190730144649.19022-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This patch adds the watchdog to the imx6ull-colibri devicetree

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 1f112ec55e5c..e3220298dd6f 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -199,6 +199,12 @@
 	assigned-clock-rates = <0>, <198000000>;
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	pinctrl_can_int: canint-grp {
 		fsl,pins = <
@@ -506,6 +512,12 @@
 			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT	0x14
 		>;
 	};
+
+	pinctrl_wdog: wdog-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
+		>;
+	};
 };
 
 &iomuxc_snvs {
-- 
2.22.0

