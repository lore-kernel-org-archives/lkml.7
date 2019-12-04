Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0281BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EF220865
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfLDK6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:58:51 -0500
Received: from inva021.nxp.com ([92.121.34.21]:49226 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfLDK6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:58:36 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 24D41201174;
        Wed,  4 Dec 2019 11:58:34 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 64B2A201177;
        Wed,  4 Dec 2019 11:58:30 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5B04240305;
        Wed,  4 Dec 2019 18:58:24 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     devicetree@vger.kernel.org, robh@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [Patch v2 4/5] arm64: dts: ls208x: Remove non-compatible driver device from qspi node
Date:   Wed,  4 Dec 2019 16:28:17 +0530
Message-Id: <1575457098-18368-5-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575457098-18368-1-git-send-email-Ashish.Kumar@nxp.com>
References: <1575457098-18368-1-git-send-email-Ashish.Kumar@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since device properties are different, so remove fsl, ls1021a-qspi.
ls1021a-qspi is to be used only for Big-endian verion of QSPI controller

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
---
v2:
Rebased to top

 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 7a0be8eaa84a..8b2fd278844b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -619,7 +619,7 @@
 
 		qspi: spi@20c0000 {
 			status = "disabled";
-			compatible = "fsl,ls2080a-qspi", "fsl,ls1021a-qspi";
+			compatible = "fsl,ls2080a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x20c0000 0x0 0x10000>,
-- 
2.17.1

