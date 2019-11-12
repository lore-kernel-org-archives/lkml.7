Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16748C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB37921A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fnpE/gzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfKLOcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:32:21 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50286 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfKLOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:32:18 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACEWCkP092759;
        Tue, 12 Nov 2019 08:32:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573569132;
        bh=Js6q+cKDSu/GtCk1xmemL71aVYq/SyFJ6i4cBFubWEw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fnpE/gzraLs3EnTOxqfCi0wVSfx87trg7LbA93poj9I6Pq9v75Sks0vDm19ITg68I
         sNszf+5DKz5oLMXQzQhJ6zV7t2RYKXmBOI1L6UcJ9bwRiewSn6kSL5rDcZy9kFIxIa
         y8E3cAZumwKzT68aCKAmLERUDIyJY4I/KW7nAGdE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACEWCbZ032051
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:32:12 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:31:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:31:54 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACEVjUQ050451;
        Tue, 12 Nov 2019 08:32:08 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/9] arm64: dts: ti: k3-j721e-main: Move secure proxy and smmu under main_navss
Date:   Tue, 12 Nov 2019 16:32:59 +0200
Message-ID: <20191112143301.3168-8-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112143301.3168-1-peter.ujfalusi@ti.com>
References: <20191112143301.3168-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure proxy (NAVSS0_SEC_PROXY0) and smmu (NAVSS0_TCU) is part of the
Navigator Subsystem.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 42 +++++++++++------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 7f320eec0459..4bf8c27ecc64 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -40,16 +40,6 @@ gic_its: gic-its@1820000 {
 		};
 	};
 
-	smmu0: smmu@36600000 {
-		compatible = "arm,smmu-v3";
-		reg = <0x0 0x36600000 0x0 0x100000>;
-		interrupt-parent = <&gic500>;
-		interrupts = <GIC_SPI 772 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 768 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "eventq", "gerror";
-		#iommu-cells = <1>;
-	};
-
 	main_gpio_intr: interrupt-controller0 {
 		compatible = "ti,sci-intr";
 		ti,intr-trigger-type = <1>;
@@ -90,6 +80,27 @@ main_udmass_inta: interrupt-controller@33d00000 {
 			ti,sci-rm-range-global-event = <0xd>;
 		};
 
+		secure_proxy_main: mailbox@32c00000 {
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <1>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x00 0x32c00000 0x00 0x100000>,
+			      <0x00 0x32400000 0x00 0x100000>,
+			      <0x00 0x32800000 0x00 0x100000>;
+			interrupt-names = "rx_011";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		smmu0: smmu@36600000 {
+			compatible = "arm,smmu-v3";
+			reg = <0x0 0x36600000 0x0 0x100000>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 772 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 768 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "eventq", "gerror";
+			#iommu-cells = <1>;
+		};
+
 		hwspinlock: spinlock@30e00000 {
 			compatible = "ti,am654-hwspinlock";
 			reg = <0x00 0x30e00000 0x00 0x1000>;
@@ -205,17 +216,6 @@ mailbox0_cluster11: mailbox@31f8b000 {
 		};
 	};
 
-	secure_proxy_main: mailbox@32c00000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg-names = "target_data", "rt", "scfg";
-		reg = <0x00 0x32c00000 0x00 0x100000>,
-		      <0x00 0x32400000 0x00 0x100000>,
-		      <0x00 0x32800000 0x00 0x100000>;
-		interrupt-names = "rx_011";
-		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
 	main_pmx0: pinmux@11c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

