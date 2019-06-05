Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A01BC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3401420866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lJ0+/gYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFEGI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:08:29 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40760 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfFEGI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:08:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5568Miq104969;
        Wed, 5 Jun 2019 01:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559714902;
        bh=kP5Be0RWpKNCwHARMR89E7X2icgm84vwwv6LLW4v034=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lJ0+/gYjUN+7JYcNzbQy/7izVeaVIDq/Xn15lzl0CcdDR+TIdtnz2dHG7tax+fM8g
         ZP//8YvWk+SnjCqOC+sIB3T89gnD2x8iLuj0+8qwGFHegzRq7bJ/NrWZWHmxZ9rcIQ
         rtiGyXUSZxpwfmQk44TfC+DKu9ri7mjT7anvJjh0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5568M9g129949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 01:08:22 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 01:08:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 01:08:21 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5568Dli066906;
        Wed, 5 Jun 2019 01:08:19 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>
CC:     <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <j-keerthy@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/3] arm64: dts: ti: am6-main: Add gpio nodes
Date:   Wed, 5 Jun 2019 11:38:45 +0530
Message-ID: <20190605060846.25314-3-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605060846.25314-1-j-keerthy@ti.com>
References: <20190605060846.25314-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio0/1 nodes under main domain. They have 96 and 90 gpios
respectively and all are capable of generating banked interrupts.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 22154f401930..24cd9005118c 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -350,4 +350,36 @@
 			ti,sci-rm-range-global-event = <0x1>;
 		};
 	};
+
+	main_gpio0:  main_gpio0@600000 {
+		compatible = "ti,k2g-gpio", "ti,keystone-gpio";
+		reg = <0x0 0x600000 0x0 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&intr_main_gpio>;
+		interrupts = <57 256>, <57 257>, <57 258>, <57 259>, <57 260>,
+				<57 261>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <96>;
+		ti,davinci-gpio-unbanked = <0>;
+		clocks = <&k3_clks 57 0>;
+		clock-names = "gpio";
+	};
+
+	main_gpio1:  main_gpio1@601000 {
+		compatible = "ti,k2g-gpio", "ti,keystone-gpio";
+		reg = <0x0 0x601000 0x0 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&intr_main_gpio>;
+		interrupts = <58 256>, <58 257>, <58 258>, <58 259>, <58 260>,
+				<58 261>;
+		interrupt-controller;
+			#interrupt-cells = <2>;
+		ti,ngpio = <90>;
+		ti,davinci-gpio-unbanked = <0>;
+		clocks = <&k3_clks 58 0>;
+		clock-names = "gpio";
+	};
 };
-- 
2.17.1

