Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF40DC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC7C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEOGCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:02:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51096 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfEOGCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:02:52 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B8162200196;
        Wed, 15 May 2019 08:02:50 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0463B200012;
        Wed, 15 May 2019 08:02:47 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 064C24029A;
        Wed, 15 May 2019 14:02:41 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [RESEND][PATCH] arm64: dts: lx2160a: Enable usb3-lpm-capable for usb3 node
Date:   Wed, 15 May 2019 14:04:34 +0800
Message-Id: <20190515060434.33581-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB3 HW LPM feature for lx2160a and active patch for
snps erratum A-010131. It will disable U1/U2 temperary when
initiate U3 request.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Depend on: https://lore.kernel.org/patchwork/patch/870134/

 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 125a8cc..0073df3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -696,6 +696,8 @@
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
+			usb3-lpm-capable;
+			snps,dis-u1u2-when-u3-quirk;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
@@ -707,6 +709,8 @@
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
+			usb3-lpm-capable;
+			snps,dis-u1u2-when-u3-quirk;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
-- 
1.7.1

