Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C7C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5199420859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390190AbfFJM6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:58:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12881 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388833AbfFJM57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:57:59 -0400
X-UUID: 44b1444b21454c46b7128d0660bccda7-20190610
X-UUID: 44b1444b21454c46b7128d0660bccda7-20190610
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 572842966; Mon, 10 Jun 2019 20:57:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 20:57:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 20:57:43 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>
Subject: [PATCH v2 12/12] arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes
Date:   Mon, 10 Jun 2019 20:55:13 +0800
Message-ID: <1560171313-28299-13-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding device_link between the IOMMU consumer and smi,
the mediatek,larb is unnecessary now.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 15f1842..06e2c09 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -921,7 +921,6 @@
 				 <&mmsys CLK_MM_MUTEX_32K>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
-			mediatek,larb = <&larb0>;
 			mediatek,vpu = <&vpu>;
 		};
 
@@ -932,7 +931,6 @@
 				 <&mmsys CLK_MM_MUTEX_32K>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		mdp_rsz0: rsz@14003000 {
@@ -962,7 +960,6 @@
 			clocks = <&mmsys CLK_MM_MDP_WDMA>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WDMA>;
-			mediatek,larb = <&larb0>;
 		};
 
 		mdp_wrot0: wrot@14007000 {
@@ -971,7 +968,6 @@
 			clocks = <&mmsys CLK_MM_MDP_WROT0>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WROT0>;
-			mediatek,larb = <&larb0>;
 		};
 
 		mdp_wrot1: wrot@14008000 {
@@ -980,7 +976,6 @@
 			clocks = <&mmsys CLK_MM_MDP_WROT1>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WROT1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		ovl0: ovl@1400c000 {
@@ -990,7 +985,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_OVL0>;
 			iommus = <&iommu M4U_PORT_DISP_OVL0>;
-			mediatek,larb = <&larb0>;
 		};
 
 		ovl1: ovl@1400d000 {
@@ -1000,7 +994,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_OVL1>;
 			iommus = <&iommu M4U_PORT_DISP_OVL1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		rdma0: rdma@1400e000 {
@@ -1010,7 +1003,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
-			mediatek,larb = <&larb0>;
 		};
 
 		rdma1: rdma@1400f000 {
@@ -1020,7 +1012,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		rdma2: rdma@14010000 {
@@ -1030,7 +1021,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA2>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA2>;
-			mediatek,larb = <&larb4>;
 		};
 
 		wdma0: wdma@14011000 {
@@ -1040,7 +1030,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_WDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_WDMA0>;
-			mediatek,larb = <&larb0>;
 		};
 
 		wdma1: wdma@14012000 {
@@ -1050,7 +1039,6 @@
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_WDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_WDMA1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		color0: color@14013000 {
@@ -1294,7 +1282,6 @@
 			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
 			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
 			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_LOW>;
-			mediatek,larb = <&larb1>;
 			iommus = <&iommu M4U_PORT_HW_VDEC_MC_EXT>,
 				 <&iommu M4U_PORT_HW_VDEC_PP_EXT>,
 				 <&iommu M4U_PORT_HW_VDEC_AVC_MV_EXT>,
@@ -1364,8 +1351,6 @@
 			      <0 0x19002000 0 0x1000>;	/* VENC_LT_SYS */
 			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>,
 				     <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
-			mediatek,larb = <&larb3>,
-					<&larb5>;
 			iommus = <&iommu M4U_PORT_VENC_RCPU>,
 				 <&iommu M4U_PORT_VENC_REC>,
 				 <&iommu M4U_PORT_VENC_BSDMA>,
-- 
1.9.1

