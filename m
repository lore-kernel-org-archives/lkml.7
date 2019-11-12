Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E75C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB08620818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bnj+YUiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfKLOcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:32:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37766 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfKLOcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:32:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACEW2Oa014821;
        Tue, 12 Nov 2019 08:32:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573569122;
        bh=+VoXDu3sr4epkCMOKVDIILQ6oh1e3KSk77l7x4EYUY0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Bnj+YUiWozJsNtMtitRci7CezhV9/WlxXrcaCYCanvKZ5gZFPDMuqIIPe8zeRcey2
         YXKgeoDqDJNH9HdF5cpXE4+98Nwe0JhCAZz7Nw5SKridBW6gdyvbq9vTDcNOyt/Gv7
         Ut2MSWxoeGkVk1rWTdE7vBKSzexUgGBaFcWWM/Pg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACEW2HP031661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:32:02 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:31:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:31:44 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACEVjUN050451;
        Tue, 12 Nov 2019 08:31:59 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/9] arm64: dts: ti: k3-am654-main: Add McASP nodes
Date:   Tue, 12 Nov 2019 16:32:56 +0200
Message-ID: <20191112143301.3168-5-peter.ujfalusi@ti.com>
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

Add the nodes for McASP 0-2 and keep them disabled because several
required properties are not present as they are board specific.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 57 ++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index be841fc44b76..6dd28202a221 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -663,4 +663,61 @@ pcie1_ep: pcie-ep@5600000 {
 		dma-coherent;
 		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
 	};
+
+	mcasp0: mcasp@02B00000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x0 0x02B00000 0x0 0x2000>,
+			<0x0 0x02B08000 0x0 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 104 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
+
+		status = "disabled";
+	};
+
+	mcasp1: mcasp@02B10000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x0 0x02B10000 0x0 0x2000>,
+			<0x0 0x02B18000 0x0 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_udmap 0xc401>, <&main_udmap 0x4401>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 105 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
+
+		status = "disabled";
+	};
+
+	mcasp2: mcasp@02B20000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x0 0x02B20000 0x0 0x2000>,
+			<0x0 0x02B28000 0x0 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_udmap 0xc402>, <&main_udmap 0x4402>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 106 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
+
+		status = "disabled";
+	};
 };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

