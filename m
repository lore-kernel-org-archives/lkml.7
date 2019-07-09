Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC734C606D7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB880216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="D4hJBmDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGIHev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:34:51 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:61852 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGIHep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1562656768; x=1565248768;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NQp0WuZNIK00kO3yS17/LbuLzrs05MUOLARt1ohweH4=;
        b=D4hJBmDJn4jYKLM4Hb9bnTPl4SRsZKS+H5LSeID29SqPmqNENG0+pbKWpBmJ+zg5
        7o8c0T+FF7Mg/Yb/Z5d6OTIWs99MsNF+CztCok1gaa/tBWVyN8rv1siApVL5l4HJ
        0Tzn5HPXL1S5ySXzdVlPMKQeK7Km6nWeVfjpEyQa808=;
X-AuditID: c39127d2-17dff70000001aee-03-5d2440009ef3
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1A.B0.06894.000442D5; Tue,  9 Jul 2019 09:19:28 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019070909192826-309707 ;
          Tue, 9 Jul 2019 09:19:28 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, martyn.welch@collabora.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH 04/10] ARM: dts: imx6ul: segin: Fix LED naming for phyCORE and PEB-EVAL-01
Date:   Tue, 9 Jul 2019 09:19:21 +0200
Message-Id: <1562656767-273566-5-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:28,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:28,
        Serialize complete at 09.07.2019 09:19:28
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWyRoCBS5fBQSXW4PJXbYv5R86xWjy86m+x
        aupOFotNj6+xWnT9WslscXnXHDaLpdcvMlk8uNjFYtG69wi7xd/tm1gsXmwRd+D2WDNvDaPH
        jrtLGD12zrrL7rFpVSebx+Yl9R4b3+1g8uj/a+DxeZNcAEcUl01Kak5mWWqRvl0CV0bD7ztM
        Be38Fd07b7M0MK7n6WLk5JAQMJHoWf+UrYuRi0NIYAejxN03h5ggnAuMEq83fmQFqWITMJJY
        MK2RCcQWEYiUeLf9NztIEbPAHkaJadevM4IkhAWiJG69ecUCYrMIqEjcnPoALM4r4CFxetsD
        Joh1chI3z3Uyg9icAp4SRy/+ArOFgGouL5jGAjJUQqCRSWLxo9OMEA1CEqcXn2WewMi3gJFh
        FaNQbmZydmpRZrZeQUZlSWqyXkrqJkZgqB6eqH5pB2PfHI9DjEwcjIcYJTiYlUR497krxwrx
        piRWVqUW5ccXleakFh9ilOZgURLn3cBbEiYkkJ5YkpqdmlqQWgSTZeLglGpgjBa13zj1xP31
        rRImAneesj77d/3qzHUqUqudF1y+brRqbtnxWeESclPzbrmytC5T49MvbrbW2WbhMU3BoYP7
        kOp1h5gSLwFV7p+24tFTp7Fm+/jsObNhgci9k49rbWovc//79+lZalpo8Bnhl8yzYyq1mA27
        UkTlVyv842f/yXOPwXWfUmWQEktxRqKhFnNRcSIAFmvFoEMCAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix node name for the user LEDs to prevent the pinctrl of the phyCORE's
leds node from being overwritten. Also use more generic names for user
LEDs.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi       |  3 +--
 arch/arm/boot/dts/imx6ul-phytec-segin-peb-eval-01.dtsi | 16 +++++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
index 1b745582911c..73266b4a889b 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -31,8 +31,7 @@
 		pinctrl-0 = <&pinctrl_gpioleds_som>;
 		compatible = "gpio-leds";
 
-		led_green {
-			label = "phycore:green";
+		phycore-green {
 			gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-peb-eval-01.dtsi b/arch/arm/boot/dts/imx6ul-phytec-segin-peb-eval-01.dtsi
index e2f38f39a6ad..2f3fd32a1167 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin-peb-eval-01.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin-peb-eval-01.dtsi
@@ -21,20 +21,22 @@
 		};
 	};
 
-	user_leds: leds {
+	user_leds: user-leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_user_leds>;
 		status = "disabled";
 
-		led_yellow {
-			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-on";
+		user-led1 {
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "gpio";
+			default-state = "on";
 		};
 
-		led_red {
-			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-on";
+		user-led2 {
+			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "gpio";
+			default-state = "on";
 		};
 	};
 };
-- 
2.7.4

