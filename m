Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0461C28EB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9142083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VgcDyoJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfFFJ4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:56:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57180 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfFFJ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:56:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x569ttIN004415;
        Thu, 6 Jun 2019 04:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559814955;
        bh=fqOkFgQf2asCwtN/sIi6jqXEdeCASBm4EnauDQ+LIjY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VgcDyoJNCM3oMj8vWDEOIQdzQ6pUwspxwySGAe+2pzBRn857sU1PPUuLwOM9gGiRE
         Ojlz22eiddheBGYdmX3eS/gxrUMWKNuQy5U/tXtVIwBGeKJ5iLerFl7lfAVx9bC7bq
         Z4N8r/+xpiTkDmtTxzRNVQJJjXHTpzovq30/U9M0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x569ttDN055598
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Jun 2019 04:55:55 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 6 Jun
 2019 04:55:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 6 Jun 2019 04:55:55 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x569thss016817;
        Thu, 6 Jun 2019 04:55:51 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>
CC:     <lokeshvutla@ti.com>, <bgolaszewski@baylibre.com>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-keerthy@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC RESEND PATCH v2 2/4] arm64: dts: ti: am6-wakeup: Add gpio node
Date:   Thu, 6 Jun 2019 15:26:18 +0530
Message-ID: <20190606095620.6211-3-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606095620.6211-1-j-keerthy@ti.com>
References: <20190606095620.6211-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio0 node under wakeup domain. This has 56 gpios
and all are capable of generating banked interrupts.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index f1ca171abdf8..9cf2c0849a24 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -74,4 +74,19 @@
 		ti,sci-dst-id = <56>;
 		ti,sci-rm-range-girq = <0x4>;
 	};
+
+	wkup_gpio0: wkup_gpio0@42110000 {
+		compatible = "ti,am654-gpio", "ti,keystone-gpio";
+		reg = <0x42110000 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&intr_wkup_gpio>;
+		interrupts = <59 128>, <59 129>, <59 130>, <59 131>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <56>;
+		ti,davinci-gpio-unbanked = <0>;
+		clocks = <&k3_clks 59 0>;
+		clock-names = "gpio";
+	};
 };
-- 
2.17.1

