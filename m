Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F76C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECCE2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A+JY+hs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfFEH50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:57:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58550 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfFEH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:57:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x557vFUd085912;
        Wed, 5 Jun 2019 02:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559721435;
        bh=e23WnTYvUjw9k/zJtezvgJoxPPb3ZOXliq0JWnFHfqk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A+JY+hs7fx3KJJGNOasexm2y0xw30xASrVtQkgAwGFxwFzbC9KWyu+69Bx9Wgubda
         nx1OZNbMrv4LYPsw7hOL9xPkycJqhBPXjPFg0pqs8DDlLd6AwZEveb6/d0wAU4WgvO
         ogpe3ICj71ay1+b4LOQ9XfsE3ID9tSL8+RY4v4Kc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x557vFnP122386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 02:57:15 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 02:57:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 02:57:15 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x557uqoS033893;
        Wed, 5 Jun 2019 02:57:12 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>
CC:     <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <j-keerthy@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 4/4] arm64: dts: ti: am654-base-board: Add gpio_keys node
Date:   Wed, 5 Jun 2019 13:27:10 +0530
Message-ID: <20190605075710.1691-5-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605075710.1691-1-j-keerthy@ti.com>
References: <20190605075710.1691-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 push buttons: SW5 and SW6 that are basically connected to
WKUP_GPIO0_24 and WKUP_GPIO0_27 respectively. Add the respective
nodes and the pinctrl data to set the mode to GPIO and Input.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index cf1aa276a1ea..ea50b6e36eff 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "k3-am654.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	compatible =  "ti,am654-evm", "ti,am654";
@@ -33,6 +34,25 @@
 			no-map;
 		};
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		pinctrl-names = "default";
+		pinctrl-0 = <&push_button_pins_default>;
+
+		sw5 {
+			label = "GPIO Key USER1";
+			linux,code = <BTN_0>;
+			gpios = <&wkup_gpio0 24 GPIO_ACTIVE_LOW>;
+		};
+
+		sw6 {
+			label = "GPIO Key USER2";
+			linux,code = <BTN_1>;
+			gpios = <&wkup_gpio0 27 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &wkup_pmx0 {
@@ -42,6 +62,13 @@
 			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT, 0) /* (AD6) WKUP_I2C0_SDA */
 		>;
 	};
+
+	push_button_pins_default: push_button__pins_default {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x0030, PIN_INPUT, 7) /* (R5) WKUP_GPIO0_24 */
+			AM65X_WKUP_IOPAD(0x003c, PIN_INPUT, 7) /* (P2) WKUP_GPIO0_27 */
+		>;
+	};
 };
 
 &main_pmx0 {
-- 
2.17.1

