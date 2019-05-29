Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C858C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FBF2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QGvgbbBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfE2JUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:20:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48924 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfE2JUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:20:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4T9Jpel094341;
        Wed, 29 May 2019 04:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559121591;
        bh=kE9EblhkeeAMFADzoHkl0IGb4+cczs03sZpOsyKHuRw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QGvgbbBel1z0dz3Hbt8Siebt5AJC4WNlLpsyUP6V3F+cJADwH4el0wWlkl05q+hD5
         mW4a5sdD1jvoveWSLDBfQGwN60JXteReVGkvThHQJFrxZG7Ium6tmQMZ6CF6PbCMhd
         kmSnZrhtL8CVwI9ok75nQO/CAL9+aDpDAvV77aKc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4T9Jp5C049985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 May 2019 04:19:51 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 29
 May 2019 04:19:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 29 May 2019 04:19:50 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4T9JVxS079377;
        Wed, 29 May 2019 04:19:48 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5/6] arm64: dts: k3-am6: Add PCIe Endpoint DT node
Date:   Wed, 29 May 2019 14:48:11 +0530
Message-ID: <20190529091812.20764-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529091812.20764-1-kishon@ti.com>
References: <20190529091812.20764-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe Endpoint DT node.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 09f18b1e70f2..fb8a13d670d2 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -393,6 +393,19 @@
 		msi-map = <0x0 &gic_its 0x0 0x10000>;
 	};
 
+	pcie0_ep: pcie-ep@5500000 {
+		compatible = "ti,am654-pcie-ep";
+		reg =  <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x8000000>, <0x0 0x5506000 0x0 0x1000>;
+		reg-names = "app", "dbics", "addr_space", "atu";
+		power-domains = <&k3_pds 120>;
+		ti,syscon-pcie-mode = <&pcie0_mode>;
+		num-ib-windows = <16>;
+		num-ob-windows = <16>;
+		max-link-speed = <3>;
+		dma-coherent;
+		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+	};
+
 	pcie1_rc: pcie@5600000 {
 		compatible = "ti,am654-pcie-rc";
 		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
@@ -411,4 +424,17 @@
 		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
 		msi-map = <0x0 &gic_its 0x10000 0x10000>;
 	};
+
+	pcie1_ep: pcie-ep@5600000 {
+		compatible = "ti,am654-pcie-ep";
+		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x4000000>, <0x0 0x5606000 0x0 0x1000>;
+		reg-names = "app", "dbics", "addr_space", "atu";
+		power-domains = <&k3_pds 121>;
+		ti,syscon-pcie-mode = <&pcie1_mode>;
+		num-ib-windows = <16>;
+		num-ob-windows = <16>;
+		max-link-speed = <3>;
+		dma-coherent;
+		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
+	};
 };
-- 
2.17.1

