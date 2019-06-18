Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78AAC31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FED20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IQhdQ+2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfFRMJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:09:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53400 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfFRMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:09:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5IC8gKT077794;
        Tue, 18 Jun 2019 07:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560859722;
        bh=y47Dmxqdu2axu8XFuL5chdma5kAOZBKLQnnNccav38w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IQhdQ+2Z3U5v56HD2juwKT/dltQ32THHc0U2z3pBTiYv41L1M35iaFwsK/eMQ7XMj
         hyVMrOUvZLfQiacARHH18TKSnon1IQipeOJOEI8hrf0g8/ZYj8ux+OX+xiqDWw98Iy
         35JvtEXGFC2nXekNoApPJ5uvyAjy6Ie9jkyPt5HI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5IC8fAB044902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Jun 2019 07:08:42 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 18
 Jun 2019 07:08:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 18 Jun 2019 07:08:41 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5IC89Gi080327;
        Tue, 18 Jun 2019 07:08:39 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>,
        <j-keerthy@ti.com>, <nm@ti.com>
Subject: [PATCH 10/10] arm64: dts: k3-am6: Add crypto accelarator node
Date:   Tue, 18 Jun 2019 17:38:43 +0530
Message-ID: <20190618120843.18777-11-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618120843.18777-1-j-keerthy@ti.com>
References: <20190618120843.18777-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto accelarator node. Define the psil specific config
node as well. This can be used in Packet Mode alone.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 91ca5bfeefc2..5e4f9ec39f01 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -91,6 +91,39 @@
 		power-domains = <&k3_pds 148>;
 	};
 
+	crypto: crypto@4E00000 {
+		compatible = "ti,sa2ul-crypto";
+		label = "crypto-aes-gbe";
+		reg = <0x0 0x4E00000 0x0 0x1200>;
+
+		status = "okay";
+		ti,psil-base = <0x4000>;
+
+		/* tx: crypto_pnp-1, rx: crypto_pnp-1 */
+		dmas = <&main_udmap &crypto 0 UDMA_DIR_TX>,
+				<&main_udmap &crypto 0 UDMA_DIR_RX>,
+				<&main_udmap &crypto 1 UDMA_DIR_RX>;
+		dma-names = "tx", "rx1", "rx2";
+
+		ti,psil-config0 {
+			linux,udma-mode = <UDMA_PKT_MODE>;
+			ti,needs-epib;
+			ti,psd-size = <64>;
+		};
+
+		ti,psil-config1 {
+			linux,udma-mode = <UDMA_PKT_MODE>;
+			ti,needs-epib;
+			ti,psd-size = <64>;
+		};
+
+		ti,psil-config2 {
+			linux,udma-mode = <UDMA_PKT_MODE>;
+			ti,needs-epib;
+			ti,psd-size = <64>;
+		};
+	};
+
 	main_pmx0: pinmux@11c000 {
 		compatible = "pinctrl-single";
 		reg = <0x0 0x11c000 0x0 0x2e4>;
-- 
2.17.1

