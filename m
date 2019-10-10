Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35EDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AC72190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbfJJI7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:59:25 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49362 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388931AbfJJIoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:44:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B3B5200925;
        Thu, 10 Oct 2019 10:44:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 04E9B200862;
        Thu, 10 Oct 2019 10:44:20 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B5F0E402DA;
        Thu, 10 Oct 2019 16:44:14 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH v2] arm64: dts: ls1028a: fix a compatible issue
Date:   Thu, 10 Oct 2019 16:33:34 +0800
Message-Id: <20191010083334.7037-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C multiplexer used on ls1028aqds is PCA9547, not PCA9847.
If the wrong compatible was used, this chip will not be able to
be probed correctly and hence fail to work.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
v2:
	- refine the description
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 5e14e5a19744..f5da9e8b0d9d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -107,7 +107,7 @@
 	status = "okay";
 
 	i2c-mux@77 {
-		compatible = "nxp,pca9847";
+		compatible = "nxp,pca9547";
 		reg = <0x77>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1

