Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C6C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073632084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfHNHYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:24:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36582 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfHNHYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:24:37 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8353520003E;
        Wed, 14 Aug 2019 09:24:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 97C0D20003A;
        Wed, 14 Aug 2019 09:24:24 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C42E740319;
        Wed, 14 Aug 2019 15:24:11 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Alison Wang <alison.wang@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>,
        Rajat Srivastava <rajat.srivastava@nxp.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/4] arm64: dts: ls1028a: fix little-big endian issue for dcfg
Date:   Wed, 14 Aug 2019 15:26:48 +0800
Message-Id: <20190814072649.8237-3-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814072649.8237-1-yinbo.zhu@nxp.com>
References: <20190814072649.8237-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dcfg use little endian that SoC register value will be correct

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index b0d4f8916ede..5538e8e354b2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -162,7 +162,7 @@
 		dcfg: syscon@1e00000 {
 			compatible = "fsl,ls1028a-dcfg", "syscon";
 			reg = <0x0 0x1e00000 0x0 0x10000>;
-			big-endian;
+			little-endian;
 		};
 
 		scfg: syscon@1fc0000 {
-- 
2.17.1

