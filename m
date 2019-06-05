Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B102FC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8938D20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YfvuyRdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfFEH5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:57:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33120 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfFEH5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:57:09 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x557v3P2030264;
        Wed, 5 Jun 2019 02:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559721423;
        bh=ALlSRG9PtHqP0CSYBVSNGSRcHisohKsxS4M0ZG0uyH0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YfvuyRdrRo2Ak6iSZGBfIu5h16Y7UhXF4/vKKlnX6DXWay0dUc6bMVGf1mnQSX2+k
         xbt9vGdUST8DRO3bUJfiagtC/UOdYJ8HOqRdPwyg4yxecBBjXVa4FYjS799/l1LFxp
         RQXi17CZw10gf2ZSKEBlq7JOH1XJz8FWC2+ZM8Bo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x557v3XR057832
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 02:57:03 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 02:57:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 02:57:02 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x557uqoP033893;
        Wed, 5 Jun 2019 02:56:58 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>, <robh+dt@kernel.org>
CC:     <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <j-keerthy@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/4] dt-bindings: gpio: davinci: Add k3 am654 compatible
Date:   Wed, 5 Jun 2019 13:27:07 +0530
Message-ID: <20190605075710.1691-2-j-keerthy@ti.com>
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

The patch adds k3 am654 compatible, specific properties and
an example.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../devicetree/bindings/gpio/gpio-davinci.txt  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
index 553b92a7e87b..bc6b4b62df83 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
@@ -5,6 +5,7 @@ Required Properties:
 			"ti,keystone-gpio": for Keystone 2 66AK2H/K, 66AK2L,
 						66AK2E SoCs
 			"ti,k2g-gpio", "ti,keystone-gpio": for 66AK2G
+			"ti,am654-gpio", "ti,keystone-gpio": for TI K3 AM654
 
 - reg: Physical base address of the controller and the size of memory mapped
        registers.
@@ -145,3 +146,20 @@ gpio0: gpio@260bf00 {
 	ti,ngpio = <32>;
 	ti,davinci-gpio-unbanked = <32>;
 };
+
+Example for K3 AM654:
+
+wkup_gpio0: wkup_gpio0@42110000 {
+	compatible = "ti,am654-gpio", "ti,keystone-gpio";
+	reg = <0x42110000 0x100>;
+	gpio-controller;
+	#gpio-cells = <2>;
+	interrupt-parent = <&intr_wkup_gpio>;
+	interrupts = <59 128>, <59 129>, <59 130>, <59 131>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	ti,ngpio = <56>;
+	ti,davinci-gpio-unbanked = <0>;
+	clocks = <&k3_clks 59 0>;
+	clock-names = "gpio";
+};
-- 
2.17.1

