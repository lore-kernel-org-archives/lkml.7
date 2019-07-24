Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C54C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664AC217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563958882;
	bh=G0FETHgUu8Nw9rJGSAGVgz91E8Mr/C4BKJTKAtvS+Hg=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=Tbpyaf5SbRcNgO8Fhmi+Gf9sgB0+uiCk1dAs8nCeGB8SXW6AkpfUzXpXOUj0g/1OX
	 G8a0m43tS6acVPhqb1pDkJzXNpQbUoPXeDT/3CS+HHQbfvQQeILBUfIIRrlPu4hiEH
	 AH+WVl2z4R51Oyp6572UTYGN7gO3SbHDNZwj9sQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfGXJBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:01:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30480 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726845AbfGXJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:01:17 -0400
X-UUID: e67dbddc74e740a39f091c19eced7d67-20190724
X-UUID: e67dbddc74e740a39f091c19eced7d67-20190724
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@kernel.org>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 891942373; Wed, 24 Jul 2019 17:01:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 17:01:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 17:01:01 +0800
From:   <ryder.lee@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Weijie Gao <weijie.gao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] arm: dts: mt7623: add Mali-450 device node
Date:   Wed, 24 Jul 2019 17:00:59 +0800
Message-ID: <af7b5a2e00eb3a4b6262807c378e43afd5f74779.1563867856.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Add a node for Mali-450.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
kmscube as well as X11 EGL tests work fine (use Lima driver).
---
 arch/arm/boot/dts/mt7623.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index a79f0b6c3429..6a9c5afb9a36 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2017-2018 MediaTek Inc.
  * Author: John Crispin <john@phrozen.org>
  *	   Sean Wang <sean.wang@mediatek.com>
+ *	   Ryder Lee <ryder.lee@mediatek.com>
  *
  */
 
@@ -733,6 +734,30 @@
 		#reset-cells = <1>;
 	};
 
+	mali: gpu@13040000 {
+		compatible = "mediatek,mt7623-mali", "arm,mali-450";
+		reg = <0 0x13040000 0 0x30000>;
+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 171 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 172 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 173 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 174 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 176 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 177 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 178 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 179 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 180 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pp1",
+				  "ppmmu1", "pp2", "ppmmu2", "pp3", "ppmmu3",
+				  "pp";
+		clocks = <&topckgen CLK_TOP_MMPLL>,
+			 <&g3dsys CLK_G3DSYS_CORE>;
+		clock-names = "bus", "core";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_MFG>;
+		resets = <&g3dsys MT2701_G3DSYS_CORE_RST>;
+	};
+
 	mmsys: syscon@14000000 {
 		compatible = "mediatek,mt7623-mmsys",
 			     "mediatek,mt2701-mmsys",
-- 
2.18.0

