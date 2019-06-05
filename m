Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0705C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C650520866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YixW1YDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfFEH5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:57:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33130 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfFEH5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:57:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x557vCpw030301;
        Wed, 5 Jun 2019 02:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559721432;
        bh=AFbZcGD05hnXKI5h5WdZTa40Gbo5LmksXVbRsgprfjs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YixW1YDU/huOgvihuCyppx4mkIavCdp/Rrf7enOleMmMJSQV5wi00+5c9e3GsThEC
         EeRC2SqftTbHjR9Gb7V+D4g39tweNMv3mrk7ti4dgmws6WMJYvSNqhPuP2KcwqJlJb
         Rx626GQPogkSb22RKFdLj4vHCbfGwbFZthb5BG9Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x557vBrt125924
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 02:57:12 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 02:57:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 02:57:11 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x557uqoR033893;
        Wed, 5 Jun 2019 02:57:08 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>
CC:     <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <j-keerthy@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 3/4] arm64: dts: ti: am6-main: Add gpio nodes
Date:   Wed, 5 Jun 2019 13:27:09 +0530
Message-ID: <20190605075710.1691-4-j-keerthy@ti.com>
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

Add gpio0/1 nodes under main domain. They have 96 and 90 gpios
respectively and all are capable of generating banked interrupts.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 22154f401930..182efe70402b 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -350,4 +350,36 @@
 			ti,sci-rm-range-global-event = <0x1>;
 		};
 	};
+
+	main_gpio0:  main_gpio0@600000 {
+		compatible = "ti,am654-gpio", "ti,keystone-gpio";
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
+		compatible = "ti,am654-gpio", "ti,keystone-gpio";
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

