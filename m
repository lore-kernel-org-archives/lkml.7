Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9337EC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7723320873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGSKTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:19:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54168 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfGSKTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:19:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A66801A0046;
        Fri, 19 Jul 2019 12:19:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4AEA41A0159;
        Fri, 19 Jul 2019 12:19:09 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1703A402E7;
        Fri, 19 Jul 2019 18:18:57 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, robh+dt@kernel.org
Cc:     leoyang.li@nxp.com, Wen He <wen.he_1@nxp.com>
Subject: [v2 4/4] arm64: ls1028aqds: Add support DP nodes for LS1028AQDS
Date:   Fri, 19 Jul 2019 18:09:42 +0800
Message-Id: <20190719100942.12016-4-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190719100942.12016-1-wen.he_1@nxp.com>
References: <20190719100942.12016-1-wen.he_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add HDP PHY Controller related nodes on the LS1028AQDS.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
Signed-off-by: Wen He <wen.he_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index de6ef39f3118..a9af6e8a6517 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -173,3 +173,15 @@
 &sata {
 	status = "okay";
 };
+
+&hdptx0 {
+	fsl,no_edid;
+	resolution = "3840x2160@60",
+		   "1920x1080@60",
+		   "1280x720@60",
+		   "720x480@60";
+	lane_mapping = <0x4e>;
+	edp_link_rate = <0x6>;
+	edp_num_lanes = <0x4>;
+	status = "okay";
+};
-- 
2.17.1

