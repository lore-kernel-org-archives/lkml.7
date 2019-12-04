Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361F5C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6BB20833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfLDK6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:58:37 -0500
Received: from inva021.nxp.com ([92.121.34.21]:49206 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfLDK6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:58:35 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1347B201180;
        Wed,  4 Dec 2019 11:58:34 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52C56201176;
        Wed,  4 Dec 2019 11:58:30 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 33975402FA;
        Wed,  4 Dec 2019 18:58:23 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     devicetree@vger.kernel.org, robh@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: [Patch v2 2/5] arm64: dts: ls1046a: Add QSPI node for ls1046afrwy
Date:   Wed,  4 Dec 2019 16:28:15 +0530
Message-Id: <1575457098-18368-3-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575457098-18368-1-git-send-email-Ashish.Kumar@nxp.com>
References: <1575457098-18368-1-git-send-email-Ashish.Kumar@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuldeep Singh <kuldeep.singh@nxp.com>

This board has a single 64MB mt25qu512a flash.
QUAD I/O read and single I/O write is tested.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
---
v2: 
Rebased to top

 arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
index 3595be0f2527..db3d303093f6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
@@ -112,6 +112,20 @@
 
 };
 
+&qspi {
+	status = "okay";
+
+	mt25qu512a0: flash@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+		reg = <0>;
+	};
+};
+
 #include "fsl-ls1046-post.dtsi"
 
 &fman0 {
-- 
2.17.1

